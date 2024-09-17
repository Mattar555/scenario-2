#!/bin/bash


create_messaging_server() {


  cat <<EOF | oc create -n integration-enablement -f -
  apiVersion: mq.ibm.com/v1beta1
  kind: QueueManager
  metadata:
    name: messaging-server
    annotations:
      com.ibm.mq/write-defaults-spec: 'false'
    namespace: integration-enablement
  spec:
    template:
      pod:
        containers:
          - name: qmgr
            env:
            - name: MQSNOAUT
              value: "yes"
    license:
      accept: true
      license: L-BMSF-5YDSLR
      use: Production
    web:
      console:
        authentication:
          provider: integration-keycloak
        authorization:
          provider: integration-keycloak
      enabled: true
    queueManager:
      mqsc:
        - configMap:
            items:
              - mq.mqsc
            name: enablement-mqsc
      availability:
        type: SingleInstance
      storage:
        queueManager:
          type: persistent-claim
        defaultClass: ocs-storagecluster-ceph-rbd
    version: 9.4.0.0-r3
EOF
}

create_messaging_server