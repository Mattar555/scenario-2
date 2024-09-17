#!/bin/bash


deploy_banking_app() {

  chars='123456789abcdefghijklmnopqrstuvwxyz'

  n=15

  basic_auth_password=

  for ((i = 0; i < n; ++i)); do
    basic_auth_password+=${chars:RANDOM%${#chars}:1}
  done
  

  endpoint=`oc get route -n integration-enablement bank-app-http -o json | jq '.spec.host' | tr -d '"'`
  oc create secret --namespace integration-enablement generic banking-app-fe-basic \
    --from-literal=url="http://$endpoint" --from-literal=password="$basic_auth_password"

  oc create -f app/k8   

}


deploy_banking_app
