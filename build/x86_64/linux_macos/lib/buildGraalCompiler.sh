#!/usr/bin/env bash

set -e
set -u
set -o pipefail

source ${SCRIPTS_LIB_DIR}/utils.sh

BASEDIR=$1
MX=$2
BUILD_ARTIFACTS_DIR=$3
echo ">>> Building Graal"
cd ${BASEDIR}
gitClone oracle \
         graal  \
         "Getting sources for the Graal compiler"

cd ${BASEDIR}/graal/compiler
export JVMCI_VERSION_CHECK='ignore'
echo ">>>> Setting environment variable JVMCI_VERSION_CHECK=${JVMCI_VERSION_CHECK}"
${MX} build
${MX} makegraaljdk --force ${BUILD_ARTIFACTS_DIR}