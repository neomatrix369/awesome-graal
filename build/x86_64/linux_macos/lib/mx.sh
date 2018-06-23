#!/usr/bin/env bash

set -e
set -u
set -o pipefail

source ${SCRIPTS_LIB_DIR}/utils.sh

setupMX() {
    BASEDIR=$1
    cd ${BASEDIR}
    gitClone graalvm \
             mx      \
             "mx is a build tool created for managing the development of (primarily) Java code"
    export MX=${BASEDIR}/mx/mx
}
