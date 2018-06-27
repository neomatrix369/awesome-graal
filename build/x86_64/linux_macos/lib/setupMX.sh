#!/usr/bin/env bash

set -e
set -u
set -o pipefail

source ${SCRIPTS_LIB_DIR}/utils.sh

BASEDIR=$1
cd ${BASEDIR}
repo=mx
gitClone graalvm \
         ${repo} \
         "${repo} is a build tool created for managing the development of (primarily) Java code"
export MX=${BASEDIR}/${repo}/mx
