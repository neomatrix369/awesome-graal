#!/usr/bin/env bash

set -e
set -u
set -o pipefail

BASEDIR=$1
MX=$2
GRAALVM_SUITE_RUNTIMES=$3
JDK_GRAAL_FOLDER_NAME=$4
BUILD_ARTIFACTS_DIR=$5

echo ""
echo ">>> Creating Archive and SHA of the newly JDK8 with Graal & Truffle at ${BUILD_ARTIFACTS_DIR}"
cd ${BASEDIR}

GRAALVM_SUITE_HOME=$(${MX} --dy ${GRAALVM_SUITE_RUNTIMES} graalvm-home)

outputArchiveFilename=$(ls ${GRAALVM_SUITE_HOME}/*.tar)
shaSumFilename=${outputArchiveFilename}.sha256sum.txt
echo ">>>> Creating Archive ${outputArchiveFilename}"
GZIP=-9 tar -czf ${outputArchiveFilename} "${JDK_GRAAL_FOLDER_NAME}"

echo ">>>> Creating a sha5 hash from ${outputArchiveFilename}"
shasum ${outputArchiveFilename} > ${shaSumFilename}

OUTPUT_DIR=${OUTPUT_DIR:-""}
if [[ ! -e "${OUTPUT_DIR}" ]]; then
    echo ">>>> Output directory not set or found"
    OUTPUT_DIR="${BASEDIR}/jdk8-with-graal-local"
    mkdir -p ${OUTPUT_DIR}
    echo ">>>> Output directory ${OUTPUT_DIR} created"
fi

mv ${outputArchiveFilename} ${OUTPUT_DIR}
mv ${shaSumFilename} ${OUTPUT_DIR}
echo ">>> ${outputArchiveFilename} and ${shaSumFilename} have been successfully created in the ${OUTPUT_DIR} folder."
