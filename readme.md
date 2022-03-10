# My over-engineered RaspberryPi4 home setup

As I don't want to mess with installing Python and Ansible itself, I decided to run Ansible from a Docker.

To build my Ansible image:

```sh
docker build -f ./myansible.Dockerfile . --tag myansible
```

To run it:

```sh
dockerbashhere myansible
```

Note: `dockerbashhere` is my zsh alias/func:

```sh
function dockerbashhere() {
    dirname=${PWD##*/}
    docker run --rm -it --entrypoint=/bin/bash -v `pwd`:/${dirname} -w /${dirname} "$@"
}
```

Now, to test my Ansible connection (run inside container):

```sh
# ping my machine
export ANSIBLE_HOST_KEY_CHECKING=False && ansible all -m ping --inventory hosts.yaml --ask-pass
```

To run my playbook (run inside container):

```sh
# copy `run-example.sh` to `run.sh` and update accordingly
# copy `config.example.yaml` to `config.yaml` and update accordingly
./run.sh
```

# Links

My setup was inspired by [How I re-over-engineered my home network for privacy and security](https://ben.balter.com/2021/09/01/how-i-re-over-engineered-my-home-network/) - [https://github.com/benbalter/pi-hole-cloudflared-docker-compose-ansible-caddy](https://github.com/benbalter/pi-hole-cloudflared-docker-compose-ansible-caddy).
