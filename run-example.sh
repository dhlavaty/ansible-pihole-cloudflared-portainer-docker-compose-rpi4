#! /bin/bash

export ANSIBLE_HOST_KEY_CHECKING=false
export ANSIBLE_INVENTORY=hosts.yaml
export ANSIBLE_ASK_PASS=true
# Must contain GitHub's "Personal access token" with "admin:public_key" and "repo" scopes
# See: https://github.com/settings/tokens
export GITHUB_TOKEN=ghp_xxx-censored--censored--censored-xxx
# Set your external URL
export WIREGUARD_EXTERNAL_SERVER_URL=my-own-domain.duckdns.org

# ...now run ansible
ansible-playbook playbook.yaml
