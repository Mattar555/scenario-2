# README


## Procedure

1) Login to API Cloud Management platform using the script provided in the utils directory for api-connect
2) Invite an Organisation owner with the following email: banking-apps-manager@organisation.com (Note, it need not be this email, but name and domain makes sense for this particular usecase)
3) Use Mailhog script to print out URL. Navigate to said URL and obtain registration link and create a new organisation using the "API Manager User Registry". Note down the username and password required to login. 
4) Login to the API Manager and create a catalog called "Core Banking Catalog". Go ahead and deploy a Portal service associated with said catalog.
5) Go to the catalog and navigate to the consumer tab and invite a consumer organisation with the following email address: coreconsumer@consumers.com. It need not be this email address but it makes sense in the context of the demonstration.
6) Go ahead and import the API from the YAML provided (As is) and publish that to a product.
6) Navigate to Mailhog and open the link. NOTE the portal service must be up and runing beforehand. So ensure the portal deployed at step 4 is complete before attempting to navigate to the aforementioned URL.
7) Fill out the steps to create the site/portal administrator user details.
8) Once done sign out and create accounts for the consumer org in question. Receive registration link from MailHog and now you can log in as said consumer.

## Links

### Installation Links

1) [Main Installation Link](https://www.ibm.com/docs/en/cloud-paks/cp-integration/16.1.0?topic=dibuc-deploying-all-api-management-subsystems-linux-x86-64-cli)
2) [Manager](https://www.ibm.com/docs/en/cloud-paks/cp-integration/16.1.0?topic=dibuc-deploying-api-manager-subsystem-linux-x86-64-cli)
3) [Analytics](https://www.ibm.com/docs/en/cloud-paks/cp-integration/16.1.0?topic=cli-deploying-api-analytics-subsystem-by-using)
4) [Portal](https://www.ibm.com/docs/en/cloud-paks/cp-integration/16.1.0?topic=dibuc-deploying-api-portal-subsystem-linux-x86-64-cli)
5) [Gateway](https://www.ibm.com/docs/en/cloud-paks/cp-integration/16.1.0?topic=cli-deploying-api-gateway-subsystem-by-using)


Either follow link 1 to deploy everything, or links 2 -> 5 for installation on a per component basis.


### OAuth Links

1) [Secure API Access with OAuth](https://mediacenter.ibm.com/media/IBM+API+ConnectA+Secure+API+Access+with+OAuth/1_l6r8scy7)
2) [IBM API Connect OAuth Implementation](https://www.linkedin.com/pulse/ibm-api-connect-oauth-implementation-awais-omer/)
3) [OAUth2 Grant Types with API Connect](https://zhimin-wen.medium.com/explore-oauth2-grant-types-with-ibm-api-connect-7195992d8eba)


### OAI Links

1) [Accept Header](https://stackoverflow.com/questions/62593055/in-openapi-3-how-to-document-that-an-accept-header-with-a-specified-value-is-ne)
2) [Describe Request Body](https://swagger.io/docs/specification/describing-request-body/)
3) [Representing XML](https://swagger.io/docs/specification/data-models/representing-xml/)
4) [Representing Array of Objects](https://www.apimatic.io/openapi/array-of-objects)


### YQ Links

1) [Main Link](https://mikefarah.gitbook.io/yq)
