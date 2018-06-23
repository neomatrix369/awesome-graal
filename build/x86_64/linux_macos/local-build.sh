#!/bin/bash

#
# Extended off the original script (see https://github.com/jponge/build-graal-jvm/blob/master/build.sh) from @jponge
#

set -e
set -u
set -o pipefail

IFS=$'\n\t'

BASEDIR=$(pwd)
RUN_TESTS=${RUN_TESTS:-""}
JDK_GRAAL_FOLDER_NAME=jdk8-with-graal
BUILD_ARTIFACTS_DIR=${BASEDIR}/${JDK_GRAAL_FOLDER_NAME}
echo ">>> Working in ${BASEDIR}"

export MX=${BASEDIR}/mx/mx

export SCRIPTS_LIB_DIR=${SCRIPTS_LIB_DIR:-$(pwd)/lib}
source ${SCRIPTS_LIB_DIR}/dependencies.sh
source ${SCRIPTS_LIB_DIR}/mx.sh
source ${SCRIPTS_LIB_DIR}/buildJDKJVMCI.sh
source ${SCRIPTS_LIB_DIR}/JDKJVMCITests.sh
source ${SCRIPTS_LIB_DIR}/env.sh
source ${SCRIPTS_LIB_DIR}/buildGraalCompiler.sh
source ${SCRIPTS_LIB_DIR}/archivingArtifacts.sh

printParameters() {
    echo "******************* Parameters ******************"
    echo "BASEDIR=${BASEDIR}"
    echo ""
    echo "JDK_GRAAL_FOLDER_NAME=${JDK_GRAAL_FOLDER_NAME}"
    echo "BUILD_ARTIFACTS_DIR=${BUILD_ARTIFACTS_DIR}"
    echo ""
    echo "RUN_TESTS=${RUN_TESTS}"
    echo "*************************************************"
}

run() {
    printParameters
    displayDependencyVersion
    time setupMX ${BASEDIR}
    time build_JDK_JVMCI ${BASEDIR} ${MX}
    time run_JDK_JVMCI_Tests ${BASEDIR} ${MX}
    setupEnvVariables ${MX}
    time buildGraalCompiler ${BASEDIR} ${MX} ${BUILD_ARTIFACTS_DIR}
    time archivingArtifacts ${BASEDIR} ${MX} ${JDK_GRAAL_FOLDER_NAME} ${BUILD_ARTIFACTS_DIR}
}

time run
