#! /bin/bash

export ANSIBLE_HOST_KEY_CHECKING=false
export ANSIBLE_INVENTORY=hosts.yaml
export ANSIBLE_ASK_PASS=true
# Set your external URL
export WIREGUARD_EXTERNAL_SERVER_URL=my-own-domain.duckdns.org

# ...now run ansible
ansible-playbook playbook.yaml
