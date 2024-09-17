#!/bin/bash


update_oai_specs() { 
  read -p 'Please enter your name: ' name
  read -p 'Please enter your email: ' email
  base_endpoint=`oc get route bank-app-http -n integration-enablement -o json | jq '.spec.host' | tr -d '"'`
  transfer_endpoint="http://$base_endpoint/performTransfer"
  detail_endpoint="http://$base_endpoint/getDetails"
  NAME=$name EMAIL=$email ENDPOINT=$transfer_endpoint yq -i '.info.contact.name = strenv(NAME) | .info.contact.email = strenv(EMAIL) | .x-ibm-configuration.properties.target-url.value = strenv(ENDPOINT)' core-banking-secure-transfers.yaml
  NAME=$name EMAIL=$email ENDPOINT=$detail_endpoint yq -i '.info.contact.name = strenv(NAME) | .info.contact.email = strenv(EMAIL) | .x-ibm-configuration.properties.target-url.value = strenv(ENDPOINT)' core-banking-secure-customer-details.yaml
}

update_oai_specs
