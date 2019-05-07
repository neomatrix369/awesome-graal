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

case "${GRAAL_JVMCI_8_TAG}" in
    "jvmci"*) 
		echo ">>>> Fetching tag ${GRAAL_JVMCI_8_TAG}" 
		git fetch origin refs/tags/${GRAAL_JVMCI_8_TAG} || true
		git checkout tags/${GRAAL_JVMCI_8_TAG}          || true
	;;
    *) echo ">>>> Fetching commit point/branch ${GRAAL_JVMCI_8_TAG}"
		git fetch --all
		git checkout ${GRAAL_JVMCI_8_TAG}
		git pull origin ${GRAAL_JVMCI_8_TAG}
	;;
esac

echo "Applying and checking patch to mx_jvmci.py..."
git apply ${SCRIPTS_LIB_DIR}/patch/mx-HotSpot-string-fix.patch || true
grep "re.search" -B 2 mx.jvmci/mx_jvmci.py || true

HOTSPOT_BUILD_JOBS=${HOTSPOT_BUILD_JOBS:-$(getAllowedThreads)}
echo "Setting HOTSPOT_BUILD_JOBS=${HOTSPOT_BUILD_JOBS}"
HOTSPOT_BUILD_JOBS=${HOTSPOT_BUILD_JOBS} ${MX} build
