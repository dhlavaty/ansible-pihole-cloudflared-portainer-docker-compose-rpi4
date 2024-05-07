# docker build -f ./myansible-new.Dockerfile . --tag myansible2

FROM debian:bullseye

COPY pdm.lock pyproject.toml /myansible/

ENV PATH="/root/.local/bin:$PATH"

RUN apt-get update \
 && apt-get install python3 sshpass curl python3-venv -y \
 && curl -sSL https://raw.githubusercontent.com/pdm-project/pdm/main/install-pdm.py | python3 - \
 && cd /myansible/ \
 && pdm install

WORKDIR /myansible/

ENTRYPOINT [ "pdm", "run", "start" ]
