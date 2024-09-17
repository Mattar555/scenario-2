#!/bin/bash

print_navigation_details() {

  endpoint=`oc get route -n integration-enablement enablement-pn -o json | jq '.spec.host' | tr -d '"'`
  echo "Platform Navigator URL...."
  echo "https://$endpoint"
}

print_navigation_details
