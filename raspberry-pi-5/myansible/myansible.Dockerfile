# docker build -f ./myansible-new.Dockerfile . --tag myansiblebookworm

FROM debian:bookworm

COPY pdm.lock pyproject.toml /myansible/

ENV PATH="/root/.local/bin:$PATH"

RUN cd /myansible/ \
    && apt-get update \
    && apt-get install python3 sshpass curl python3-venv -y \
    && curl -sSL https://pdm-project.org/install-pdm.py | python3 - \
    && pdm install

WORKDIR /myansible/

ENTRYPOINT [ "pdm", "run", "start" ]
