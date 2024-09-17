#!/bin/bash

## You will notice we don't specify the StorageClass Reference in the YAML. For this practicum, we aren't too interested in persistence. The clusters are short lived and will be available for only a number of days.

deploy_navigator() {
  read -p 'Do you accept the license? True/False: ' license_accept
  if [ "$license_accept" = "true" ]  || [ "$license_accept" = "True" ] || [ "$license_accept" = "t" ] || [ "$license_accept" = "T" ] || [ "$license_accept" = "TRUE" ]; then
  echo "License accepted. Deploying the Navigator!!"
  oc create -f platform-navigator.yaml
  else
    echo "Please accept the license"
  fi
}


wait_healthy() {
  # Ensure status converges to desired state prior to check below.
  # sleep 10
  # Takes about 25 minutes, which is 1500s.
  # oc wait --timeout=1500s -n integration-enablement --for=jsonpath='{.status.conditions[0].type}'=Ready PlatformNavigator/enablement
  echo "This takes about 20 minutes, please check back then!"
}

deploy_navigator
wait_healthy