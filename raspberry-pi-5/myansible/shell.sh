#! /bin/sh
docker run --rm -it --entrypoint=/bin/sh -v `pwd`:/myansible/workdir myansiblebookworm
