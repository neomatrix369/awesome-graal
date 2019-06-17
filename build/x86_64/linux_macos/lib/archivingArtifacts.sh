#!/usr/bin/env bash

set -e
set -u
set -o pipefail

BASEDIR=$1
MX=$2
JDK_GRAAL_FOLDER_NAME=$3
BUILD_ARTIFACTS_DIR=$4

createTarGzArchive() {
	TARGET_FOLDER_NAME=$1
	archiveFilename=$2

	echo ">>>> Creating Archive ${archiveFilename}"
	GZIP=-9 tar -czf ${archiveFilename} "${TARGET_FOLDER_NAME}"
}

createSHAFromArchive() {
	archiveFilename=$1
	shaSumFilename=$2

	echo ">>>> Creating a sha5 hash from ${archiveFilename}"
	shasum ${archiveFilename} > ${shaSumFilename}
}

moveFilesToOutputFolder() {
	archiveFilename=$1
	shaSumFilename=$2
	OUTPUT_DIR=$3
	mv ${archiveFilename} ${OUTPUT_DIR}
	mv ${shaSumFilename} ${OUTPUT_DIR}
	echo ">>> ${archiveFilename} and ${shaSumFilename} have been successfully created in the ${OUTPUT_DIR} folder."	
}

OUTPUT_DIR=${OUTPUT_DIR:-""}
if [[ ! -e "${OUTPUT_DIR}" ]]; then
    echo ">>>> Output directory not set or found"
    OUTPUT_DIR="${BASEDIR}/jdk8-with-graal-local"
    cd ${BASEDIR}
    mkdir -p ${OUTPUT_DIR}
    echo ">>>> Output directory ${OUTPUT_DIR} created"
fi

createJDKArchiveAndSha() {
    echo ""
    echo ">>> Creating JDK Archive and SHA of the newly built JDK8 with Graal & Truffle at ${BUILD_ARTIFACTS_DIR}"

    cd ${BASEDIR}
    outputArchiveFilename=${JDK_GRAAL_FOLDER_NAME}-jdk.tar.gz
    createTarGzArchive ${JDK_GRAAL_FOLDER_NAME} ${outputArchiveFilename}
    shaSumFilename=${outputArchiveFilename}.sha256sum.txt
    createSHAFromArchive ${outputArchiveFilename} ${shaSumFilename}
    moveFilesToOutputFolder ${outputArchiveFilename} ${shaSumFilename} ${OUTPUT_DIR}
}

createJREArchiveAndSha() {
    echo ""
    echo ">>> Creating JRE Archive and SHA of the newly built JDK8 with Graal & Truffle at ${BUILD_ARTIFACTS_DIR}"

    cd ${BASEDIR}
    cd ${JDK_GRAAL_FOLDER_NAME}
    outputArchiveFilename=${JDK_GRAAL_FOLDER_NAME}-jre.tar.gz
    createTarGzArchive jre ${outputArchiveFilename}
    shaSumFilename=${outputArchiveFilename}.sha256sum.txt
    createSHAFromArchive ${outputArchiveFilename} ${shaSumFilename}
    moveFilesToOutputFolder ${outputArchiveFilename} ${shaSumFilename} ${OUTPUT_DIR}
}

createGraalComponentsArchiveAndSha() {
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
}

createJDKArchiveAndSha
createJREArchiveAndSha
createGraalComponentsArchiveAndSha