FROM debian:stretch

# set correct locale needed by Ansible
RUN apt-get update && apt-get install -y locales \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# install Ansible & my Ansible dependencies
RUN apt-get install -y python3-pip sshpass && pip3 install ansible \
    && ansible-galaxy collection install community.crypto \
    && ansible-galaxy collection install community.general \
    && rm -rf /var/lib/apt/lists/*

# HOWTO build
# $ docker build -f ./myansible.Dockerfile . --tag myansible
