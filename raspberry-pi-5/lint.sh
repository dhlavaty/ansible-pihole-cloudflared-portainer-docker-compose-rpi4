#! /bin/sh
docker run --rm -it --entrypoint "/root/.local/bin/pdm" --workdir "/myansible/workdir" -v `pwd`:/myansible/workdir myansiblebookworm run ansible-lint
