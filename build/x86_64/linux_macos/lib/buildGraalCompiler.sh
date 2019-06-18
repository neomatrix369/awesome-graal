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
         master \
         "Getting sources for the Graal compiler"

cd ${BASEDIR}/graal/compiler
export JVMCI_VERSION_CHECK='ignore'
echo ">>>> Setting environment variable JVMCI_VERSION_CHECK=${JVMCI_VERSION_CHECK}"
HOTSPOT_BUILD_JOBS=${HOTSPOT_BUILD_JOBS:-$(getAllowedThreads)}
echo ">>>> Setting HOTSPOT_BUILD_JOBS=${HOTSPOT_BUILD_JOBS}"
echo ">>>> Setting BUILD_GRAAL_COMPILER_VERBOSE_MODE_FLAG=${BUILD_GRAAL_COMPILER_VERBOSE_MODE_FLAG:-}"
export JAVA_OPTS="${MAX_HEAP_SIZE_FLAG:-} -XX:+HeapDumpOnOutOfMemoryError -XX:+ShowMessageBoxOnError -XX:ErrorFile=${BASEDIR}/hs_err_pid%p.log -XX:HeapDumpPath=${BASEDIR}/java-heap-dump-%p ${JAVA_OPTS:-}"
echo ">>>> Setting JAVA_OPTS=${JAVA_OPTS}"

set -x 
HOTSPOT_BUILD_JOBS=${HOTSPOT_BUILD_JOBS} ${MX} ${BUILD_GRAAL_COMPILER_VERBOSE_MODE_FLAG:-} "-A-J${JAVA_OPTS}" build
set +x

MAX_CPUS=${MAX_CPUS:-$(getAvailableThreads)}
echo ">>>> Setting MAX_CPUS=${MAX_CPUS}"
set -x
${MX} --max-cpus ${MAX_CPUS} "-A-J${JAVA_OPTS}" makegraaljdk --force ${BUILD_ARTIFACTS_DIR}
set +x 