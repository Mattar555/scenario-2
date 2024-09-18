#!/bin/bash


deploy_flink() {

  local name=$1
  cat <<EOF | oc create -n integration-enablement -f -
  apiVersion: flink.apache.org/v1beta1
  kind: FlinkDeployment
  metadata:
    name: $1 
  spec:
    flinkConfiguration:
      license.use: EventAutomationNonProduction
      license.license: 'L-KCVZ-JL5CRM'
      license.accept: 'true'
      execution.checkpointing.interval: '5000'
      state.backend.type: rocksdb
      state.checkpoints.num-retained: '3'
      taskmanager.numberOfTaskSlots: '4'
      table.exec.source.idle-timeout: '30 s'
      restart-strategy: failure-rate
      restart-strategy.failure-rate.max-failures-per-interval: '5'
      restart-strategy.failure-rate.failure-rate-interval: '5 min'
      restart-strategy.failure-rate.delay: '30 s'
    serviceAccount: flink
    podTemplate:
      apiVersion: v1
      kind: Pod
      metadata:
        name: pod-template
      spec:
        containers:
          - name: flink-main-container
            volumeMounts:
              - name: flink-logs
                mountPath: /opt/flink/log
        volumes:
          - name: flink-logs
            emptyDir: {}
    jobManager:
      resource:
        memory: '2048m'
        cpu: 0.5
    taskManager:
      resource:
        memory: '2048m'
        cpu: 0.5
    mode: native
EOF
}

wait_flink_healthy() {
  local name=$1
  # Wait for deployment to happen
  sleep 60
  oc rollout status --timeout=10m -n integration-enablement deployment $1 

}

deploy_event_processing() {

  local flink_name=$1
  local ep_name=$2
  cat <<EOF | oc create -n integration-enablement -f -
  apiVersion: events.ibm.com/v1beta1
  kind: EventProcessing
  metadata:
    name: $ep_name
  spec:
    license:
      accept: true
      license: L-KCVZ-JL5CRM
      use: EventAutomationNonProduction
    flink:
      endpoint: $flink_name-rest:8081
    authoring:
      authConfig:
        authType: LOCAL
      storage:
        type: ephemeral
EOF
}


wait_processing_healthy() {
  
  # Follow the commands here: https://ibm.github.io/event-automation/ep/installing/post-installation/
  # Below may be an acceptable alternative...
  local ep_name=$1

  # Wait for statefulset to materialise. It should not be a sleep, ideally.
  sleep 100
  oc rollout status -n integration-enablement statefulset $ep_name-ibm-ep-sts

  # NOTE: This is not enough, we need to wait until the instance itself registers healthy, as opposed to the STS.
  oc wait --timeout=200s -n integration-enablement --for=jsonpath='{.status.phase}'='Running' EventProcessing/enablement-event-processing
}


set_up_local_users() {

  local ep_name=$1
  oc get secret $ep_name-ibm-ep-user-credentials -n integration-enablement -o json | jq --arg users "$(cat local-users.json | base64)" '.data["user-credentials.json"]=$users' | oc apply -f -
  oc get secret $ep_name-ibm-ep-user-roles -n integration-enablement -o json | jq --arg users "$(cat local-user-mapping.json | base64)" '.data["user-mapping.json"]=$users' | oc apply -f -
} 


event_processing_instance=enablement-event-processing
flink_instance=enablement-flink-instance
deploy_flink $flink_instance
wait_flink_healthy $flink_instance 
deploy_event_processing $flink_instance $event_processing_instance
wait_processing_healthy $event_processing_instance
set_up_local_users $event_processing_instance

