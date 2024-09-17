#!/bin/bash




create_config() {

  config=`cat odbc.ini | base64 -w 0`
  cat <<EOF | oc create -n integration-enablement -f -
  apiVersion: appconnect.ibm.com/v1beta1
  kind: Configuration
  metadata:
    labels:
      backup.appconnect.ibm.com/component: configuration
      bcdr-candidate: t
      component-name: appconnect
    name: odbcini
  spec:
    description: ODBC INI configuration to access PSQL
    contents: $config
    type: odbc
    version: 12.0.12-r3
EOF

}

create_config