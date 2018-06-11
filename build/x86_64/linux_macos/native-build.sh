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

if [[ -e "mx/.git" ]]; then
    echo ">>> mx already exists: using the current version"
else
    echo ">>> Getting mx: mx is a build tool created for managing the development of (primarily) Java code"
    git clone --depth=1 http://github.com/graalvm/mx.git
fi

MX=${BASEDIR}/mx/mx

if [[ -e "graal-jvmci-8/.git" ]]; then
    echo ">>> graal-jvmci-8 already exists: using the current version"
else
    echo ">>> Getting Graal JVMCI for JDK8"
    git clone --depth=1 http://github.com/graalvm/graal-jvmci-8.git
fi

echo ">>> Building a JDK8 with JVMCI..."
cd ${BASEDIR}/graal-jvmci-8/
${MX} --java-home ${JAVA_HOME} build

if [[ "${RUN_TESTS}" = "false" ]]; then
   echo ">>>> Skipping unit tests, won't run them."
else
    echo ">>>> Running unit tests..."
    ${MX} --java-home ${JAVA_HOME} unittest
fi

JDK8_JVMCI_IMAGE=$(${MX} --java-home ${JAVA_HOME} jdkhome)
export JAVA_HOME=${JDK8_JVMCI_IMAGE}
echo ">>> Using ${JDK8_JVMCI_IMAGE}"

echo ">>> Building Graal"
cd ${BASEDIR}
if [[ -e "graal/.git" ]]; then
    echo ">>> graal already exists: using the current version"
else
    git clone --depth=1 http://github.com/oracle/graal.git
fi

cd ${BASEDIR}/graal/compiler
export JVMCI_VERSION_CHECK='ignore'
echo ">>>> Setting environment variable JVMCI_VERSION_CHECK=${JVMCI_VERSION_CHECK}"
${MX} build
${MX} makegraaljdk ${BUILD_ARTIFACTS_DIR}

echo ""
echo ">>> All good, now pick your JDK from ${BUILD_ARTIFACTS_DIR} :-)"

echo ""
echo ">>> Creating Archive and SHA of the newly JDK8 with Graal & Truffle at ${BUILD_ARTIFACTS_DIR}"
cd ${BASEDIR}
outputArchiveFilename=${JDK_GRAAL_FOLDER_NAME}.tar.gz
shaSumFilename=${outputArchiveFilename}.sha256sum.txt
echo ">>>> Creating Archive ${outputArchiveFilename}"
GZIP=-9 tar -czf ${outputArchiveFilename} "${JDK_GRAAL_FOLDER_NAME}"
echo ">>>> Creating a sha5 hash from ${outputArchiveFilename}"
shasum ${outputArchiveFilename} > ${shaSumFilename}

OUTPUT_DIR=${OUTPUT_DIR:-""}
if [[ ! -e "${OUTPUT_DIR}" ]]; then
    echo ">>>> Output directory not set or found"
    OUTPUT_DIR="${BASEDIR}/jdk8-with-graal-via-native"
    mkdir -p ${OUTPUT_DIR}
    echo ">>>> Output directory ${OUTPUT_DIR} created"
fi

mv ${outputArchiveFilename} ${OUTPUT_DIR}
mv ${shaSumFilename} ${OUTPUT_DIR}

echo ">>> ${outputArchiveFilename} and ${shaSumFilename} have been successfully created in the ${OUTPUT_DIR} folder."
