kind: Project
apiVersion: project.openshift.io/v1
metadata:
  name: integration-enablement
  labels:
    kubernetes.io/metadata.name: integration-enablemennt
  annotations:
    openshift.io/description: This project will house assets and labs required to familiairse oneself with the major components of the Cloud Pak for Integration offering.
    openshift.io/display-name: Integration Enablement
---
kind: Project
apiVersion: project.openshift.io/v1
metadata:
  name: ibm-common-services
  labels:
    kubernetes.io/metadata.name: ibm-common-services
  annotations:
    openshift.io/description: Common Services for IBM Cloud Paks.
    openshift.io/display-name: IBM Common Services
