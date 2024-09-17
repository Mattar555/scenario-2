#!/bin/bash



install_subscriptions() {
  local subscription=$1
  local subscription_file=$2
  local source=""
  local channel=`jq '.subscriptions.'$subscription'.channel' $subscription_file | tr -d '"'`
  local name=`jq '.subscriptions.'$subscription'.name' $subscription_file | tr -d '"'`
  native=`jq '.subscriptions.'$subscription'.native' $subscription_file | tr -d '"'`
  if $native; then
     source=`oc get catalogsource -n openshift-marketplace | grep $subscription  | awk '{print $1}'`
  else
     source=`jq '.subscriptions.'$subscription'.catalogsource' $subscription_file | tr -d '"'`
  fi
  cat <<EOF | oc create -n openshift-operators -f -
  apiVersion: operators.coreos.com/v1alpha1
  kind: Subscription
  metadata:
    name: $name
  spec:
    channel: $channel
    name: $name
    source: $source
    sourceNamespace: openshift-marketplace
EOF
}


subscriptions() {

  local subscription_file=$1
  subscriptions=( $(cat $1 | jq -r '.subscriptions| keys[]') )

  for subscription in "${subscriptions[@]}"; do
      install_subscriptions $subscription $1
  done

}

ensure_healthy() {

  # Compared to CatalogSources, it is not very obvious how to programmatically check the status of a Subscription, hence the sleep command. There probably is a better way but I'm too lazy to figure it out.
  sleep 200

}

signal_completion() {

  echo ""
  echo "All done! Install the subscriptions now!!"
  echo ""
}

subscriptions prerequisite-subscriptions.json
ensure_healthy
subscriptions subscriptions.json
ensure_healthy
signal_completion