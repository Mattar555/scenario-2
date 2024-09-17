#!/bin/bash


download_from_source() {

  curl -L https://github.com/IBM/ibm-pak/releases/download/v1.16.0/oc-ibm_pak-linux-amd64.tar.gz -o oc-ibm_pak-linux-amd64.tar.gz
  curl -L https://github.com/IBM/ibm-pak/releases/download/v1.16.0/oc-ibm_pak-linux-amd64.tar.gz.sig -o oc-ibm_pak-linux-amd64.tar.gz.sig
 tar -xvf oc-ibm_pak-linux-amd64.tar.gz
 mv oc-ibm_pak-linux-amd64 oc-ibm_pak

}


cleanup() {

  rm *.tar.gz 
  rm *.tar.gz.sig
  rm LICENSE  
}

download_from_source
cleanup
