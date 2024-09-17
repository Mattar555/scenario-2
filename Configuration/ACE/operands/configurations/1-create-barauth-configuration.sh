#!/bin/bash




create_bar_auth_secret() {

  config=`cat pull.json | base64 -w 0`
  cat <<EOF | oc create -n integration-enablement -f -
  kind: Secret
  apiVersion: v1
  metadata:
    name: barauth-pull-config-mfknk
    labels:
      appconnect.ibm.com/kind: Configuration
      app.kubernetes.io/instance: barauth-pull-config
      bcdr-candidate: t
      release: barauth-pull-config
      app.kubernetes.io/component: configuration
      app.kubernetes.io/managed-by: ibm-appconnect
      app.kubernetes.io/name: barauth-pull-config
      component-name: appconnect
      backup.appconnect.ibm.com/component: configuration
  data:
    configuration: $config
  type: Opaque
EOF

}


create_bar_auth() {
  sleep 2
  cat <<EOF | oc create -n integration-enablement -f -
  apiVersion: appconnect.ibm.com/v1beta1
  kind: Configuration
  metadata:
    generation: 1
    labels:
      backup.appconnect.ibm.com/component: configuration
      bcdr-candidate: t
      component-name: appconnect
    name: barauth-pull-config
  spec:
    description: Confguration required to pull bar files from the specified ICOS location.
    secretName: barauth-pull-config-mfknk
    type: barauth
    version: 12.0.12-r3
EOF



}


create_bar_auth_secret
create_bar_auth