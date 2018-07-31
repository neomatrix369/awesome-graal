#!/bin/bash

#
# Extended off the original script (see https://github.com/jponge/build-graal-jvm/blob/master/build.sh) from @jponge
#

set -e
set -u
set -o pipefail

IFS=$'\n\t'

BASEDIR=$(pwd)
export RUN_TESTS=${RUN_TESTS:-"true"}
JDK_GRAAL_FOLDER_NAME=jdk8-with-graal
export GRAAL_JVMCI_8_TAG=jvmci-0.46
BUILD_ARTIFACTS_DIR=${BASEDIR}/${JDK_GRAAL_FOLDER_NAME}
GRAALVM_SUITE_RUNTIMES=${GRAALVM_SUITE_RUNTIMES:-'/substratevm,/tools,sulong,/graal-nodejs,/fastr,truffleruby,graalpython'}

export JAVA_OPTS="$(echo ${DOCKER_JAVA_OPTS:-""} ${JAVA_OPTS:-})"
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:-}:/usr/lib/x86_64-linux-gnu/
export FASTR_RELEASE="true"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

echo ">>> Working in ${BASEDIR}"

export MX=${BASEDIR}/mx/mx

export SCRIPTS_LIB_DIR=${SCRIPTS_LIB_DIR:-$(pwd)/lib}

printParameters() {
    echo "******************* Parameters ******************"
    echo "BASEDIR=${BASEDIR}"
    echo ""
    echo "JDK_GRAAL_FOLDER_NAME=${JDK_GRAAL_FOLDER_NAME}"
    echo "GRAAL_JVMCI_8_TAG=${GRAAL_JVMCI_8_TAG}"
    echo "BUILD_ARTIFACTS_DIR=${BUILD_ARTIFACTS_DIR}"
    echo "GRAALVM_SUITE_RUNTIMES=${GRAALVM_SUITE_RUNTIMES}"
    echo ""
    echo "RUN_TESTS=${RUN_TESTS}"
    echo "JAVA_HOME=${JAVA_HOME}"
    echo "JAVA_OPTS=${JAVA_OPTS}"
    echo "FASTR_RELEASE=${FASTR_RELEASE}"
    echo "LANG=${LANG}"
    echo "LC_ALL=${LC_ALL}"
    echo "LC_CTYPE=${LC_CTYPE}"
    echo "*************************************************"
}

run() {
    printParameters
    ${SCRIPTS_LIB_DIR}/displayDependencyVersion.sh
    time ${SCRIPTS_LIB_DIR}/setupMX.sh ${BASEDIR}
    time ${SCRIPTS_LIB_DIR}/build_JDK_JVMCI.sh ${BASEDIR} ${MX}
    time ${SCRIPTS_LIB_DIR}/run_JDK_JVMCI_Tests.sh ${BASEDIR} ${MX}
    source ${SCRIPTS_LIB_DIR}/setEnvVariables.sh ${BASEDIR} ${MX}
    time ${SCRIPTS_LIB_DIR}/buildGraalCompiler.sh ${BASEDIR} ${MX} ${BUILD_ARTIFACTS_DIR}
    time ${SCRIPTS_LIB_DIR}/buildGraalVMSuite.sh ${BASEDIR} ${MX} ${GRAALVM_SUITE_RUNTIMES}
    time ${SCRIPTS_LIB_DIR}/archivingArtifacts.sh ${BASEDIR} ${MX} ${JDK_GRAAL_FOLDER_NAME} ${BUILD_ARTIFACTS_DIR}
}

time run
