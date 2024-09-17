#!/bin/bash

deploy_interfaces() {

  oc create -f user-interfaces
}

deploy_interfaces
