#!/bin/bash


create_secret() {

  read -sp 'Enter your entitlement key here: ' pullSecret
  echo ""
  oc create secret docker-registry ibm-entitlement-key \
    --docker-username=cp \
    --docker-password=${pullSecret} \
    --docker-server=cp.icr.io \
    --namespace=integration-enablement


  # The Platform Navigator requires this, in the event we don't use a global pull secret.
  oc create secret docker-registry ibm-entitlement-key \
    --docker-username=cp \
    --docker-password=${pullSecret} \
    --docker-server=cp.icr.io \
    --namespace=openshift-operators
}

create_secret