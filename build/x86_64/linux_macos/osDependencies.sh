#!/bin/bash

set -e
set -u
set -o pipefail

SUDO_CMD=""
if [[ -f "/etc/sudoers" ]]; then
   SUDO_CMD=sudo
fi

set -ex;                     \
    sed -i "s/deb.debian.org/cdn-fastly.deb.debian.org/" /etc/apt/sources.list \
    && sed -i "s/security.debian.org/cdn-fastly.debian.org\/debian-security/" /etc/apt/sources.list \
    && ${SUDO_CMD} apt-get update        \
    && ${SUDO_CMD} apt-get install -y    \
        build-essential      \
        ca-certificates      \
        ed                   \
        gcc                  \
        gfortran             \
        git                  \
        libbz2-dev           \
        libc++-dev           \
        libcurl4-openssl-dev \
        liblzma-dev          \
        libmpc-dev           \
        libpcre3-dev         \
        libpq-dev            \
        libreadline-dev      \
        libssl-dev           \
        locales              \
        make                 \
        python-pip           \
        python2.7            \
        python2.7-dev        \
        ssh                  \
        texlive-latex-base   \
        zlib1g-dev

set -ex;                     \
    ${SUDO_CMD} apt-get install -y texlive-fonts-recommended \
                        libpcre3 libpcre3-dev
set -ex;                          \
    ${SUDO_CMD} rm -r /var/lib/apt/lists/*    \
            && ${SUDO_CMD} apt-get autoremove \
            && ${SUDO_CMD} apt-get clean      \
            && ldconfig

locale-gen en_US.UTF-8
