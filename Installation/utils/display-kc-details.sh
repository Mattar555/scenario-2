#!/bin/bash


display_kc_details() {

  username=`oc get secret cs-keycloak-initial-admin -n ibm-common-services -o json | jq '.data.username' | tr -d '"' | base64 -d`
  password=`oc get secret cs-keycloak-initial-admin -n ibm-common-services -o json | jq '.data.password' | tr -d '"' | base64 -d`
  echo "username: $username"
  echo "password: $password"
  route=`oc get route -n ibm-common-services keycloak -o json | jq '.spec.host' | tr -d '"'`
  echo "route: https://$route"

}

display_kc_details
