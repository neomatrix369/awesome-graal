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
         "deep"

echo ">>> Building a JDK8 with JVMCI..."
cd ${BASEDIR}/graal-jvmci-8/
git fetch origin refs/tags/${GRAAL_JVMCI_8_TAG} || true
git checkout tags/${GRAAL_JVMCI_8_TAG}          || true

echo "Applying and checking patch to mx_jvmci.py..."
git apply ${SCRIPTS_LIB_DIR}/patch/mx-HotSpot-string-fix.patch
grep "re.search" -B 2 mx.jvmci/mx_jvmci.py

HOTSPOT_BUILD_JOBS=${HOTSPOT_BUILD_JOBS:-$(getAllowedThreads)}
echo "Setting HOTSPOT_BUILD_JOBS=${HOTSPOT_BUILD_JOBS}"
HOTSPOT_BUILD_JOBS=${HOTSPOT_BUILD_JOBS} ${MX} build
