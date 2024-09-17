#!/bin/bash


verify_icos_client() {

  read -p 'Please enter your name: ' name
  echo "$name TEST ICOS" > $name.txt
  echo "Uploading file to ICOS client..."
  oc cp $name.txt -n integration-enablement icos-client:/tmp
  echo "Upload complete. Removing file..."
  rm $name.txt
  echo "Wait for upload complete.."
  sleep 5
  echo "Performing download..."
  curl https://sydney-cos.s3.au-syd.cloud-object-storage.appdomain.cloud/$name.txt --output $name.txt
}


verify_icos_client