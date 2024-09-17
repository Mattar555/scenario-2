#!/bin/bash


deploy_icos_client() {

  oc create -f k8/secret.yaml
  sleep 5
  oc create -f k8/pod.yaml
  oc wait -n integration-enablement --for=jsonpath='{.status.phase}'=Running pod/icos-client
}

deploy_icos_client