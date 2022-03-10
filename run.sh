#! /bin/bash

export ANSIBLE_HOST_KEY_CHECKING=false
export ANSIBLE_INVENTORY=hosts.yaml
export ANSIBLE_ASK_PASS=true

# ...now run ansible
ansible-playbook playbook.yaml
