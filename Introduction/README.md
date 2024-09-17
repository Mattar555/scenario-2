# Introduction

### [Topic 2.1: Cloud Pak for Integration](README.md#ibm-cloud-pak-for-integration)

## IBM Cloud Pak for Integration

IBM Cloud Pak for Integration brings together IBM’s market-leading middleware capabilities to support a broad range of
integration styles and use cases. With powerful deployment, lifecycle management, and production services running on
Red Hat OpenShift, it enables clients to leverage the latest agile integration practices, simplify the management of
their integration architecture, whilst reducing cost. Deployment of IBM Cloud Pak for Integration requires an instance of
a RedHat OpenShift cluster. That said, some capabilities can run standalone on non OpenShift clusters, such as Amazon's
and Azure's EKS and AKS respectively. And this list is subject to grow with the passing of time.

A IBM Cloud Pak® for Integration installation consists of a Red Hat® OpenShift® Container Platform cluster with one or 
more Cloud Pak for Integration operators and associated operands deployed in the cluster.

The following clusters are supported:

- **Managed OpenShift** clusters. These clusters are built and managed by the cloud-provider:

    - RedHat OpenShift on IBM Cloud (ROKS)
    - RedHat OpenShift on AWS (ROSA)
    - Azure RedHat OpenShift (ARO)

- **Installer Provisioned Infrastructure (IPI)** clusters are created using the openshift-install command, as provided and managed by RedHat.

    - Azure
    - AWS
    - Google
    - VMware

- **User Provisioned Infrastructure (UPI)** clusters, which are built manually to accommodate an unsupported environment. Although this path is not preferred, there are valid customer situations that may warrant the UPI implementation. However, with UPI, the customer/service integrator is typically responsible for building the additional structure to ensure the cluster is production ready.

Customers may also request the cluster not have internet access (i.e **restricted network or airgapped**). In this 
exercise, our cluster(s) will have outbound access to the internet, in order to download and run the required media.

For the purpose of this workshop, IBM Cloud Pak for Integration will be installed on VMWare on IBM Cloud.

[Go back to -> Table of Contents](../README.md)

[Go to next topic -> Solution Architecture](../Architecture/README.md)