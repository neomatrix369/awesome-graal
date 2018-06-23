#!/bin/bash

set -e
set -u
set -o pipefail

RUBY_VERSION=${1:-"2.2.2"}

apt-get install -qy \
    curl \
    openssl \
    patch \
    gawk \
    g++ \
    gcc \
    gnupg2 \
    make \
    libc6-dev \
    libreadline6-dev \
    zlib1g-dev \
    libssl-dev \
    libyaml-dev \
    libsqlite3-dev \
    sqlite3 \
    autoconf \
    libgdbm-dev \
    libncurses5-dev \
    automake \
    libtool \
    bison \
    pkg-config \
    libffi-dev \
    libgmp-dev \
    --no-install-recommends && rm -r /var/lib/apt/lists/*

# Install RVM
curl -#LO https://rvm.io/mpapis.asc && gpg --import mpapis.asc
curl -sSL https://get.rvm.io | bash -s stable

export RVM_PATH="/usr/local/rvm"
export PATH="${RVM_PATH}/bin:${PATH}"

# Install RUBY
rvm install ${RUBY_VERSION}
rvm --default use ${RUBY_VERSION}

export RUBY_PATH="/usr/local/rvm/rubies/ruby-${RUBY_VERSION}"
export GEM_HOME="/usr/local/rvm/gems/ruby-${RUBY_VERSION}"
export GEM_PATH="/usr/local/rvm/gems/ruby-${RUBY_VERSION}"
export PATH="${RUBY_PATH}/bin:${GEM_HOME}/bin:${PATH}"
rvm info
