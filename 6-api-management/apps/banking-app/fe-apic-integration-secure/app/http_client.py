import re
import os
import json
import time
import random
import datetime
import requests
import xml.etree.ElementTree as ET


def cache_customer_details():
    base_endpoint = os.environ.get("URL")
    client_id = os.environ.get("CLIENT_ID")
    client_secret = os.environ.get("CLIENT_SECRET")
    headers = {'X-IBM-Client-id': client_id, 'X-IBM-Client-Secret': client_secret}
    details_endpoint = base_endpoint + "/getSecureDetails"
    customers = requests.get(url=details_endpoint, headers=headers, verify=False).text
    with open("/tmp/customers.xml", mode="w") as customer_content:
        customer_content.write(customers)


def set_customer():
    tree = ET.parse('/tmp/customers.xml')
    root = tree.getroot()
    num_customers = len(root.findall('Customers'))
    chosen_customer_number = random.randint(0, num_customers - 1)
    return root.findall('Customers')[chosen_customer_number].find('customer_id').text


def get_customer_id_from_name(customer_name):
    # Assuming best case scenario, will implement error checking (incorrect/non existent customer_name) at a later point
    tree = ET.parse('/tmp/customers.xml')
    root = tree.getroot()
    for customer in root.findall('Customers'):
        if customer.find('first_name').text == customer_name:
            return customer.find('customer_id').text


def perform_transfer(transfer_request, customer_id):
    pattern = re.compile("^Transfer\s\d+\sto\s\w+$")
    if pattern.match(transfer_request) is not None:
        amount = int(re.search(r'\d+', transfer_request).group())
        transferee = transfer_request.split()[-1]
        data = {
            'transfer_id': random.randint(1, 2147483647),
            'from_id': customer_id,
            'to_id': get_customer_id_from_name(transferee),
            'transfer_amount': amount,
            'transfer_date': datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        }
        client_id = os.environ.get("CLIENT_ID")
        client_secret = os.environ.get("CLIENT_SECRET")
        headers = {
            'Content-type': 'application/json',
            'X-IBM-Client-id': client_id,
            'X-IBM-Client-Secret': client_secret
        }
        base_endpoint = os.environ.get("URL")
        transfer_endpoint = base_endpoint + "/performSecureTransfer"
        http_response = requests.post(
            url=transfer_endpoint,
            data=json.dumps(data),
            headers=headers,
            verify=False
        )
        if http_response.status_code == 200:
            response = "Transfer completed successfully!"
            for word in response.split():
                yield word + " "
                time.sleep(0.05)
        else:
            response = "An error occurred when performing the transaction: " + http_response.text
            for word in response.split():
                yield word + " "
                time.sleep(0.05)
    else:
        response = "Please abide by the format specified in the help page!"
        for word in response.split():
            yield word + " "
            time.sleep(0.05)

