#!/bin/bash


deploy_api_connect() {

  cat <<EOF | oc create -n integration-enablement -f -
  apiVersion: apiconnect.ibm.com/v1beta1
  kind: APIConnectCluster
  metadata:
    name: enablement-api-management
    namespace: integration-enablement
  spec:
    license:
      accept: true 
      license: L-DZZQ-MGVN8V
      metric: VIRTUAL_PROCESSOR_CORE
      use: production
    analytics:
      mtlsValidateClient: true 
    portal:
      mtlsValidateClient: true
    profile: n1xc7.m48
    version: 10.0.8.0
    storageClassName: ocs-storagecluster-ceph-rbd
EOF
}


wait_healthy() {
  
  oc wait --timeout=1800s -n integration-enablement --for=jsonpath='{.status.phase}'='Running' APIConnectCluster/enablement-api-management

}

deploy_api_connect
wait_healthy
