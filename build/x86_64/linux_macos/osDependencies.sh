#!/bin/bash

#
# Copyright 2019 Mani Sarkar
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e
set -u
set -o pipefail
SUDO_CMD=""
if [[ -f "/etc/sudoers" ]]; then
   SUDO_CMD=sudo
fi

if [[ "${PYTHON_VERSION:-2.7}" = "2.7" ]]; then
    PYTHON_DEPS="python-pip python2.7 python2.7-dev"
else
    PYTHON_DEPS="libpq-dev libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev"
fi

if [[ "$(uname)" == "Linux" ]]; then
    set -ex;                     \
        sed -i "s/deb.debian.org/cdn-fastly.deb.debian.org/" /etc/apt/sources.list || true \
        && sed -i "s/security.debian.org/cdn-fastly.debian.org\/debian-security/" /etc/apt/sources.list || true \
        && ${SUDO_CMD} apt-get update        \
        && ${SUDO_CMD} apt-get install -y    \
            build-essential      \
            ca-certificates      \
            gfortran             \
            git                  \
            libc++-dev           \
            libcurl4-openssl-dev \
            liblzma-dev          \
            libmpc-dev           \
            libpcre3             \
            libpcre3-dev         \
            locales              \
            make                 \
            ${PYTHON_DEPS}       \
            ssh                  \
            texlive-latex-base   \
            texlive-fonts-recommended \
            strace               \
            && ${SUDO_CMD} rm -r /var/lib/apt/lists/*  \
                && ${SUDO_CMD} apt-get autoremove      \
                && ${SUDO_CMD} apt-get clean           \
                && ${SUDO_CMD} ldconfig                            \
                && ${SUDO_CMD} locale-gen en_US.UTF-8
elif [[ "$(uname)" == "Darwin" ]]; then
    brew install python
    brew install texlive-latex-base libpcre3 libpcre3-dev
    brew install pdflatex
    brew cask install mactex
    brew install gcc
    brew install lzma liblzma xz z
    brew install pcre ed

    update_dyld_shared_cache
else
    echo "*** Does not have equivalent dependencies/packages for your platform ($(uname)). Check if one of platforms supported in '$0' works for your platform. ***"
fi

if [[ "${PYTHON_VERSION:-2.7}" = "3.7" ]]; then
    wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
    tar xzf Python-3.7.3.tgz
    cd Python-3.7.3
    ./configure --enable-optimizations
    ${SUDO_CMD} make altinstall

    ln -sf /usr/local/bin/python3.7 /usr/bin/python
    ln -sf /usr/local/bin/python3.7 /usr/bin/python3.7
    ln -sf /usr/local/bin/python3.7 /usr/bin/python3

    pip install future
fi