#!/usr/bin/env bash

set -e
set -u
set -o pipefail

source ${SCRIPTS_LIB_DIR}/utils.sh
GRAAL_JVMCI_8_TAG=${GRAAL_JVMCI_8_TAG:-master}

BASEDIR=$1
MX=$2
cd ${BASEDIR}
gitClone graalvm       \
         graal-jvmci-8 \
         "Getting Graal JVMCI for JDK8" \
         "doNotUpdate"

echo ">>> Building a JDK8 with JVMCI..."
cd ${BASEDIR}/graal-jvmci-8/
git fetch origin refs/tags/${GRAAL_JVMCI_8_TAG} || true
git checkout tags/${GRAAL_JVMCI_8_TAG} -b ${GRAAL_JVMCI_8_TAG} || true
HOTSPOT_BUILD_JOBS=${HOTSPOT_BUILD_JOBS:-$(getAllowedThreads)}
echo "Setting HOTSPOT_BUILD_JOBS=${HOTSPOT_BUILD_JOBS}"
HOTSPOT_BUILD_JOBS=${HOTSPOT_BUILD_JOBS} ${MX} build
