# README

## Implementation Notes

An instance of on_create will trigger 2 (or more, depending on level of nesting) of on_modified events.
As an example, assuming we are watching /tmp. 

If I create a file called /tmp/file.log. Then this will trigger an on_create event with the file in question (event.src_path = /tmp/file.log) and TWO instances of on_modified.

The first instance of on modified would have an event src path of /tmp and the second instance of on_modified would be
/tmp/file.log. 
This means we NEED to guard instances of on_modified where the event source path is a directory We need to GUARD against instances of directories in the on_modified portion of the code.

Now, this means (unless we check for the last modified date and the created date and if they were in close proximity to one another, we don't perform a multipart upload as this implies it is a creation only), that a creation event will trigger a modified event(s) which means the file will be initially uploaded once, and then uploaded again (second upload would be for no reason). That said, subsequent updates to the same file will ONLY trigger one instance of an on_modified event.

As it stands, we perform no checks, the file will be INITIALLY uploaded twice, subsequent modifications will
be uploaded only once.

Now, as it stands, there is NO way to find the original time/date of creation. See [here](https://stackoverflow.com/questions/17958987/difference-between-python-getmtime-and-getctime-in-unix-system)


## Links

### Links - ICOS

The following assumes a "public" ICOS bucket is created.

1) First, create service credentials as outlined [here](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-service-credentials). You will need value associated with the "apikey" field.
2) Next, for the bucket in question, head over to the configuration tab and retrieve the endpoint in question.
3) Finally, head over the resources section in IBM Cloud, click on the row corresponding to your COS bucket and copy the CRN.

Use the code examples provided in the Python Links section to build your application.


### Links - Python

1) [Watchdog Example Usage](https://pypi.org/project/watchdog/)
2) [ICOS Code Examples](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-python#python-examples)
3) [Ctime vs Mtime](https://stackoverflow.com/questions/17958987/difference-between-python-getmtime-and-getctime-in-unix-system)


## Misc links

1) [Initiate a Multipart upload](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-large-objects#large-objects-multipart-api-initiate)
2) [Using the API](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-upload#upload-api)
3) [Code Examples for Python](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-python#python-examples)
4) [Service Credentials for ICOS](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-service-credentials)
