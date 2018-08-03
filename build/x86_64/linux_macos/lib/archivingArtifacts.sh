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

GRAALVM_SUITE_HOME=$( cd ${BASEDIR}/graal/vm && ${MX} --dy "${GRAALVM_SUITE_RUNTIMES}" graalvm-home )

OS_PLATFORM="$(uname | tr '[:upper:]' '[:lower:]')"
PLATFORM_ARCH="$( cd ${BASEDIR}/graal/vm/mxbuild && ls -1 -d ${OS_PLATFORM}* )"
outputArchiveFilename="graalvm-${PLATFORM_ARCH}.tgz"

echo ">>>> Creating archive ${outputArchiveFilename} from contents of '${GRAALVM_SUITE_HOME}'"
( cd ${GRAALVM_SUITE_HOME} && GZIP=-9 tar -czf ${BASEDIR}/${outputArchiveFilename} . )

shaSumFilename="${outputArchiveFilename}.sha256sum.txt"
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
