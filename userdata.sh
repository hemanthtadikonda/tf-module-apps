#!/bin/bash

set-hostname ${component}

yum install ansible -y &>>/opt/userdata.log

pip3.11 install botocore boto3   &>>/opt/userdata.log

ansible-pull -i localhost, -U https://github.com/hemanthtadikonda/Ansible-roboshop.git main.yml -e component=${component}  &>>/opt/userdata.log