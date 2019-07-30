#!/bin/bash

set -e
set -u
set -o pipefail

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Building GraalVM Suite"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

source ${SCRIPTS_LIB_DIR}/utils.sh

BASEDIR=$1
MX=$2
GRAALVM_SUITE_RUNTIMES=$3

echo ">>> Building GraalVM Suite"
echo "JAVA_OPTS=${JAVA_OPTS}"

echo ">>>> Currently JAVA_HOME=${JAVA_HOME}"
JDK8_JVMCI_HOME="$(cd ${BASEDIR}/graal-jvmci-8/ && ${MX} --java-home ${JAVA_HOME} jdkhome)"
export JVMCI_VERSION_CHECK='ignore'
export JAVA_HOME=${JDK8_JVMCI_HOME}
echo ">>>> Newly set JAVA_HOME=${JAVA_HOME}"

${SCRIPTS_LIB_DIR}/applyPatches.sh ${BASEDIR}

cd ${BASEDIR}/graal/vm

MAX_CPUS=${MAX_CPUS:-$(getAvailableThreads)}
echo ">>>> Setting MAX_CPUS=${MAX_CPUS}"

set -x
${MX} --max-cpus ${MAX_CPUS}         \
      --dy ${GRAALVM_SUITE_RUNTIMES} \
      --java-home=${JDK8_JVMCI_HOME} \
      --force-bash-launchers=true    \
      build
set +x