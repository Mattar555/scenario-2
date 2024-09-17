#!/bin/bash


deploy_pgsql_subscription() {
  oc create -f cloud-native-pg-sub.yaml
}

wait_healthy_sub() {

  # Takes a few seconds, but extending it out in the event of transient errors
  sleep 60
}


deploy_db() {
  oc create -f pg-cluster.yaml
}

wait_healthy_cluster() {

 oc wait --timeout=400s -n integration-enablement --for=jsonpath='{.status.phase}'='Cluster in healthy state' Cluster/enablement-persistence
}

# Not required in the event communication are restricted within the scope of the cluster. 
# Besides, Routes in OpenShift expose HTTP traffic, not layer 3 TCP/IP  as in the case with pgsql connections.
expose_service() {

  oc create -f pg-route.yaml
}


populate_db() {

  oc create -f db-init.yaml
}

deploy_pgsql_subscription
wait_healthy_sub
deploy_db
wait_healthy_cluster
populate_db

