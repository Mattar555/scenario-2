#!/bin/bash


create_db_secret() {

  local username=`oc get secret enablement-persistence-app -n integration-enablement -o json | jq '.data.username' |  tr -d '"' | base64 -d`
  local password=`oc get secret enablement-persistence-app -n integration-enablement -o json | jq '.data.password' |  tr -d '"' | base64 -d`
  local connection_string="mqsisetdbparms -w /home/aceuser/ace-server -n odbc::POSTGRESQL -u $username -p $password"
  local encoded_connection_string=`echo $connection_string | base64 -w 0`
  cat <<EOF | oc create -n integration-enablement -f -
  kind: Secret
  apiVersion: v1
  metadata:
    name: acedbauth-mjs49
    labels:
      appconnect.ibm.com/kind: Configuration
      app.kubernetes.io/instance: acedbauth
      bcdr-candidate: t
      release: barauth-pull-config
      app.kubernetes.io/component: configuration
      app.kubernetes.io/managed-by: ibm-appconnect
      app.kubernetes.io/name: acedbauth 
      component-name: appconnect
      backup.appconnect.ibm.com/component: configuration
  data:
    configuration: $encoded_connection_string
  type: Opaque
EOF
  
}


create_config() {

  # Ensure committed/persisted in ETCD
  sleep 5
  cat <<EOF | oc create -n integration-enablement -f -
  apiVersion: appconnect.ibm.com/v1beta1
  kind: Configuration
  metadata:
    labels:
      backup.appconnect.ibm.com/component: configuration
      bcdr-candidate: t
      component-name: appconnect
    name: acedbauth
  spec:
    description: Configuration required to access database from ace integration server
    secretName: acedbauth-mjs49
    type: setdbparms
    version: 12.0.12-r3
EOF

}

create_db_secret
create_config
