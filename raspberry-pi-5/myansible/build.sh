#! /bin/sh

cd myansible/
docker build -f ./myansible.Dockerfile . --tag myansiblebookworm
