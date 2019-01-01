#!/usr/bin/env bash

set -e
set -u
set -o pipefail

BASEDIR=$1
MX=$2
JDK_GRAAL_FOLDER_NAME=$3
BUILD_ARTIFACTS_DIR=$4

echo ""
echo ">>> Creating Archive and SHA of the newly JDK8 with Graal & Truffle at ${BUILD_ARTIFACTS_DIR}"

cd ${BASEDIR}
outputArchiveFilename=${JDK_GRAAL_FOLDER_NAME}.tar.gz

createTarGzArchive() {
	JDK_GRAAL_FOLDER_NAME=$1
	outputArchiveFilename=$2

	echo ">>>> Creating Archive ${outputArchiveFilename}"
	GZIP=-9 tar -czf ${outputArchiveFilename} "${JDK_GRAAL_FOLDER_NAME}"
}

createSHAFromArchive() {
	outputArchiveFilename=$1
	shaSumFilename=$2

	echo ">>>> Creating a sha5 hash from ${outputArchiveFilename}"
	shasum ${outputArchiveFilename} > ${shaSumFilename}
}

moveFilesToOutputFolder() {
	outputArchiveFilename=$1
	shaSumFilename=$2
	OUTPUT_DIR=$3
	mv ${outputArchiveFilename} ${OUTPUT_DIR}
	mv ${shaSumFilename} ${OUTPUT_DIR}
	echo ">>> ${outputArchiveFilename} and ${shaSumFilename} have been successfully created in the ${OUTPUT_DIR} folder."	
}

createTarGzArchive ${JDK_GRAAL_FOLDER_NAME} ${outputArchiveFilename}

shaSumFilename=${outputArchiveFilename}.sha256sum.txt

createSHAFromArchive ${outputArchiveFilename} ${shaSumFilename}

OUTPUT_DIR=${OUTPUT_DIR:-""}
if [[ ! -e "${OUTPUT_DIR}" ]]; then
    echo ">>>> Output directory not set or found"
    OUTPUT_DIR="${BASEDIR}/jdk8-with-graal-local"
    mkdir -p ${OUTPUT_DIR}
    echo ">>>> Output directory ${OUTPUT_DIR} created"
fi

moveFilesToOutputFolder ${outputArchiveFilename} ${shaSumFilename} ${OUTPUT_DIR}

echo ""
echo ">>> Creating Archive and SHA of Graal & Truffle components at ${BUILD_ARTIFACTS_DIR}"

cd ${BASEDIR}
GRAAL_ARTIFACTS_FOLDER_NAME=graal-artifacts
outputArchiveFilename=${GRAAL_ARTIFACTS_FOLDER_NAME}.tar.gz

mkdir -p ${GRAAL_ARTIFACTS_FOLDER_NAME}

cp ${JDK_GRAAL_FOLDER_NAME}/jre/lib/jvmci/graal.jar ${GRAAL_ARTIFACTS_FOLDER_NAME}/
cp ${JDK_GRAAL_FOLDER_NAME}/jre/lib/jvmci/graal-management.jar ${GRAAL_ARTIFACTS_FOLDER_NAME}/
cp ${JDK_GRAAL_FOLDER_NAME}/jre/lib/boot/graal-sdk.jar ${GRAAL_ARTIFACTS_FOLDER_NAME}/
cp ${JDK_GRAAL_FOLDER_NAME}/jre/lib/truffle/truffle-api.jar ${GRAAL_ARTIFACTS_FOLDER_NAME}/

createTarGzArchive ${GRAAL_ARTIFACTS_FOLDER_NAME} ${outputArchiveFilename}

shaSumFilename=${outputArchiveFilename}.sha256sum.txt
createSHAFromArchive ${outputArchiveFilename} ${shaSumFilename}

moveFilesToOutputFolder ${outputArchiveFilename} ${shaSumFilename} ${OUTPUT_DIR}