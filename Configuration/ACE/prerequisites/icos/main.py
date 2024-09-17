import os
import time
import logging
import ibm_boto3
from watchdog.observers import Observer
from ibm_botocore.client import Config, ClientError
from watchdog.events import FileSystemEvent, FileCreatedEvent, FileModifiedEvent, FileSystemEventHandler

logging.basicConfig(level=logging.INFO)


def multi_part_upload(bucket_name, item_name, file_path):
    try:
        logging.info("Initiate file transfer for {0} to bucket: {1}\n".format(item_name, bucket_name))
        # print("Starting file transfer for {0} to bucket: {1}\n".format(item_name, bucket_name))
        # Upload in chunks of 5 MB
        part_size = 1024 * 1024 * 5
        # Set threshold to 50 MB, the bar files used in this exercise should almost never exceed this.
        file_threshold = 1024 * 1024 * 50
        # set the transfer threshold and chunk size
        transfer_config = ibm_boto3.s3.transfer.TransferConfig(
            multipart_threshold=file_threshold,
            multipart_chunksize=part_size
        )
        with open(file_path, "rb") as file_data:
            cos_client.upload_fileobj(Bucket=bucket_name, Key=item_name, Fileobj=file_data, Config=transfer_config)
        logging.info("File {0} transferred successfully\n".format(item_name))
    except ClientError as client_error:
        logging.error("Client error {0}\n".format(client_error))
    except Exception as exception:
        logging.error("Unable to complete multi-part upload: {}".format(exception))


def get_buckets():
    logging.info("Retrieving list of buckets")
    try:
        buckets = cos_client.list_buckets()
        for bucket in buckets["Buckets"]:
            logging.info("Bucket Name: {0}".format(bucket["Name"]))
    except ClientError as client_error:
        logging.error("Client error {0}\n".format(client_error))
    except Exception as exception:
        logging.error("Unable to complete multi-part upload: {}".format(exception))


class FSEventHandler(FileSystemEventHandler):

    # See README

    def on_created(self, event: FileCreatedEvent) -> None:
        head_tail = os.path.split(event.src_path)
        file_name = head_tail[1]
        multi_part_upload(bucket_name=os.getenv("COS_BUCKET"),
                          item_name=file_name,
                          file_path=event.src_path
                          )

    def on_modified(self, event: FileModifiedEvent) -> None:
        head_tail = os.path.split(event.src_path)
        file_name = head_tail[1]
        if not os.path.isdir(event.src_path):
            multi_part_upload(bucket_name=os.getenv("COS_BUCKET"),
                              item_name=file_name,
                              file_path=event.src_path
                              )


if __name__ == '__main__':
    cos_client = ibm_boto3.client("s3",
                                  ibm_api_key_id=os.getenv("COS_API_KEY_ID"),
                                  ibm_service_instance_id=os.getenv("COS_INSTANCE_CRN"),
                                  config=Config(signature_version="oauth"),
                                  endpoint_url=os.getenv("COS_ENDPOINT"))
    event_handler = FSEventHandler()
    observer = Observer()
    observer.schedule(event_handler, "/tmp", recursive=False)
    observer.start()
    try:
        while True:
            time.sleep(1)
    finally:
        observer.stop()
        observer.join()
