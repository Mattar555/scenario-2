#!/bin/bash

# Need to update this script to read in bar url and perform a replace.

create_integration_server() {
 
  read -p 'Please enter the name of your bar file: ' barfile
  bar_endpoint="https://sydney-cos.s3.au-syd.cloud-object-storage.appdomain.cloud/$barfile.bar"
  echo "$bar_endpoint"
  ENDPOINT=$bar_endpoint yq -i '.spec.barURL[0]= strenv(ENDPOINT)' runtime.yaml 
  oc create -f runtime.yaml
}


create_integration_server
