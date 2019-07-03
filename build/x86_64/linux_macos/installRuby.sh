#!/bin/bash

set -e
set -u
set -o pipefail

SUDO_CMD=""
RVM_SUDO_CMD=""
if [[ -f "/etc/sudoers" ]]; then
   SUDO_CMD=sudo
   RVM_SUDO_CMD=rvmsudo
fi

RUBY_VERSION=${1:-"2.2.2"}

${SUDO_CMD} apt-get update && ${SUDO_CMD} apt-get install -qy \
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
        && ${SUDO_CMD} rm -fr /var/lib/apt/lists/*

# Install RVM
curl -sSL https://rvm.io/mpapis.asc | gpg --no-tty --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg --no-tty --import -
curl -sSL https://get.rvm.io | bash -s stable || true

if [[ -z "${RVM_SUDO_CMD}" ]]; then
    export rvmsudo_secure_path=0
else
    CONTAINS_SECURE_PATH=$(${SUDO_CMD} cat /etc/sudoers | grep secure_path || true)
    if [[ -z "${CONTAINS_SECURE_PATH}" ]]; then
        export rvmsudo_secure_path=0
    else
        export rvmsudo_secure_path=1
    fi
fi

# Install RUBY
set -x
if [[ -f "/.dockerenv" ]]; then
    export RVM_PATH=/usr/local/rvm
else 
    export RVM_PATH="/opt/$(whoami)/.rvm"
fi
export PATH="${RVM_PATH}/bin:${PATH}"

echo "Installing ruby ${RUBY_VERSION} using rvm"
${RVM_SUDO_CMD} rvm install ${RUBY_VERSION} || (true && ${RVM_SUDO_CMD} rvm get stable)
${RVM_SUDO_CMD} rvm --default use ${RUBY_VERSION}
set +x

export RUBY_PATH="${RVM_PATH}/rubies/ruby-${RUBY_VERSION}"
export GEM_HOME="${RVM_PATH}/gems/ruby-${RUBY_VERSION}"
export GEM_PATH="${RVM_PATH}/gems/ruby-${RUBY_VERSION}"
export PATH="${RUBY_PATH}/bin:${GEM_HOME}/bin:${PATH}"

rvm info