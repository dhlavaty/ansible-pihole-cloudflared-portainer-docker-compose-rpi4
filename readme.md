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
# copy `config.example.yaml` to `config.yaml` and update accordingly
./run.sh
```

# Backup tasks

To use my backup (using [Restic](https://restic.readthedocs.io/)), you have to initialize your `Restic` repository first.

Quick howto:

1. Save your Google Account Project ID in `backup_google_project_id`
2. Create Google Cloud storage bucket (I use `Coldline` availability) and set its name into `backup_google_bucket`
3. Create Service Account (use `Storage Object Admin` role), add `Key` into it, and download it as a JSON file. Save path into `backup_google_service_account_key_json`
4. Initialize your Restic repository like so:

```sh
export GOOGLE_PROJECT_ID=google-project-id
export GOOGLE_APPLICATION_CREDENTIALS=subdir/service-account-key.json
restic init -r gs:google-bucket-name:/ --verbose
# Pick your password and save it into `backup_restic_password`
```

After your Restic repo was initialized, you can run our backup task using ansible.

# Links

My setup was inspired by [How I re-over-engineered my home network for privacy and security](https://ben.balter.com/2021/09/01/how-i-re-over-engineered-my-home-network/) - [https://github.com/benbalter/pi-hole-cloudflared-docker-compose-ansible-caddy](https://github.com/benbalter/pi-hole-cloudflared-docker-compose-ansible-caddy).
