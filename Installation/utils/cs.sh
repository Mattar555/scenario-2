#!/bin/bash

install() {

  sources=( $(cat catalog-sources.json | jq -r '.catalogsources | keys[]') )

  for source in "${sources[@]}"; do
    install_catalog_source $source
  done

}

install_catalog_source() {
  echo $1
  local source=$1
  version=`jq '.catalogsources.'$source'.version' catalog-sources.json | tr -d '"'`
  name=`jq '.catalogsources.'$source'.name' catalog-sources.json | tr -d '"'`
  arch=`jq '.catalogsources.'$source'.arch' catalog-sources.json | tr -d '"'`
  ./oc-ibm_pak get ${name} --version ${version} --skip-dependencies
  ./oc-ibm_pak generate mirror-manifests ${name} icr.io --version ${version}
  oc apply -f ~/.ibm-pak/data/mirror/${name}/${version}/catalog-sources.yaml
  oc apply -f ~/.ibm-pak/data/mirror/${name}/${version}/catalog-sources-linux-${arch}.yaml
}


ensure_healthy() { 

  # Ensure the CatalogSources are committed to etcd 
  sleep 5
  # Need an effective way to filter for only the required catalogsources, as opposed to all of them below.
  oc get catalogsource -n openshift-marketplace | cut -d' ' -f1 | tail -n +2 > cs.log
  while read cs; do
    echo "$cs"
    # Default timeout is 30 seconds, this may not be enough.
    oc wait --timeout=200s -n openshift-marketplace --for=jsonpath='{.status.connectionState.lastObservedState}'=READY catalogsource/$cs
  done < cs.log  
  
}

cleanup() {
  rm cs.log
  rm oc-ibm_pak
}


signal_completion() {

  echo ""
  echo "All done! Install the subscriptions now!!"
  echo ""
}

install
ensure_healthy
cleanup
signal_completion
