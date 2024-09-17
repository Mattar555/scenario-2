#!/bin/bash


deploy_banking_app() {


  read -sp 'Please enter the client id for your application: ' client_id
  echo ""
  read -sp 'Please enter the client secret for your application: ' client_secret
  echo ""
  local catalog_name="core-banking-catalog"
  local producer_org_name="core-banking"

  chars='123456789abcdefghijklmnopqrstuvwxyz'

  n=15

  basic_auth_password=

  for ((i = 0; i < n; ++i)); do
    basic_auth_password+=${chars:RANDOM%${#chars}:1}
  done
  

  route_name=`oc get route -n integration-enablement | grep gateway | head -n 1 | awk '{print $1;}'`
  base_endpoint=`oc -n integration-enablement get route $route_name -o json | jq '.spec.host' | tr -d '"'`
  endpoint=https://$base_endpoint/$producer_org_name/$catalog_name
  oc create secret --namespace integration-enablement generic banking-app-fe-basic --from-literal=url="$endpoint" --from-literal=client_id="$client_id" --from-literal=client_secret="$client_secret" --from-literal=password="$basic_auth_password"

  oc create -f app/k8   

}


deploy_banking_app
