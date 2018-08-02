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
        make                          \
        python-pip                    \
        python2.7                     \
        python2.7-dev                 \
        ssh

set -ex;                                       \
    ${SUDO_CMD} rm -r /var/lib/apt/lists/*     \
            && ${SUDO_CMD} apt-get autoremove  \
            && ${SUDO_CMD} apt-get clean
