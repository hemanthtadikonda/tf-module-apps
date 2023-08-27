#!/bin/bash

yum install ansible -y

ansible-pull -i localhost, -U https://github.com/hemanthtadikonda/Ansible-roboshop.git main.yml -e component = ${component}