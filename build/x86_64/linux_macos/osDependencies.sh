#!/bin/bash

set -e
set -u
set -o pipefail

set -ex;                     \
    sed -i "s/deb.debian.org/cdn-fastly.deb.debian.org/" /etc/apt/sources.list \
    && sed -i "s/security.debian.org/cdn-fastly.debian.org\/debian-security/" /etc/apt/sources.list \
    && apt-get update        \
    && apt-get install -y    \
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
    apt-get install -y texlive-fonts-recommended \
                        libpcre3 libpcre3-dev
set -ex;                          \
    rm -r /var/lib/apt/lists/*    \
            && apt-get autoremove \
            && apt-get clean      \
            && ldconfig

locale-gen en_US.UTF-8
