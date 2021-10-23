# My over-engineered RaspberryPi4 home setup

As I don't want to mess with installing Python and Ansible itself, I decided to run Ansible from a Docker.

```sh
dockerbashhere suckowbiz/ansible-playbook

# Now inside container, install additional dependencies:
> apt install sshpass
> ansible-galaxy collection install community.crypto
> ansible-galaxy collection install community.general
```

`dockerbashhere` is my zsh alias/func:

```sh
function dockerbashhere() {
    dirname=${PWD##*/}
    docker run --rm -it --entrypoint=/bin/bash -v `pwd`:/${dirname} -w /${dirname} "$@"
}
```

Now, to test my Ansible connection:

```sh
# ping my machine
> export ANSIBLE_HOST_KEY_CHECKING=False && ansible all -m ping --inventory hosts.yaml --ask-pass
```

To run my playbook

```sh
# set env variables
> export ANSIBLE_HOST_KEY_CHECKING=false
> export ANSIBLE_INVENTORY=hosts.yaml
> export ANSIBLE_ASK_PASS=true
# Must contain GitHub personal token with "admin:public_key" and "repo" scopes
> export GITHUB_TOKEN=ghp_xxx-censored--censored--censored-xxx

# ...now run ansible
> ansible-playbook playbook.yaml
```

# Links

My setup was inspired by [How I re-over-engineered my home network for privacy and security](https://ben.balter.com/2021/09/01/how-i-re-over-engineered-my-home-network/) - [https://github.com/benbalter/pi-hole-cloudflared-docker-compose-ansible-caddy](https://github.com/benbalter/pi-hole-cloudflared-docker-compose-ansible-caddy).
