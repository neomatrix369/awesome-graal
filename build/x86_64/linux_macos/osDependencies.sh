#!/bin/bash

set -e
set -u
set -o pipefail

SUDO_CMD=""
if [[ -f "/etc/sudoers" ]]; then
   SUDO_CMD=sudo
fi

if [[ "$(uname)" == "Linux" ]]; then
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
            libpcre3             \
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
            texlive-fonts-recommended \
            zlib1g-dev           \
            && ${SUDO_CMD} rm -r /var/lib/apt/lists/*  \
                && ${SUDO_CMD} apt-get autoremove      \
                && ${SUDO_CMD} apt-get clean           \
                && ldconfig                            \
                && locale-gen en_US.UTF-8
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
