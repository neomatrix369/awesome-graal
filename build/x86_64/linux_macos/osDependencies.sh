#!/bin/bash

set -e
set -u
set -o pipefail

SUDO_CMD=""
if [[ -f "/etc/sudoers" ]]; then
   SUDO_CMD=sudo
fi

set -ex;                              \
    ${SUDO_CMD} apt-get update        \
    && ${SUDO_CMD} apt-get install -y \
        build-essential               \
        ca-certificates               \
        gcc                           \
        git                           \
        libpq-dev                     \
        libreadline-gplv2-dev         \
        libncursesw5-dev libssl-dev   \
        libsqlite3-dev tk-dev         \
        libgdbm-dev libc6-dev         \
        libbz2-dev libffi-dev         \
        zlib1g-dev                    \
        make                          \
        ssh

set -ex;                                       \
    ${SUDO_CMD} rm -r /var/lib/apt/lists/*     \
            && ${SUDO_CMD} apt-get autoremove  \
            && ${SUDO_CMD} apt-get clean || true

wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
tar xzf Python-3.7.3.tgz
cd Python-3.7.3
./configure --enable-optimizations
make altinstall
ln -sf /usr/local/bin/python3.7 /usr/bin/python
ln -sf /usr/local/bin/python3.7 /usr/bin/python3.7
ln -sf /usr/local/bin/python3.7 /usr/bin/python3

pip install future