#!/usr/bin/env bash

set -e
set -u
set -o pipefail

source ${SCRIPTS_LIB_DIR}/utils.sh

BASEDIR=$1

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Archiving logs"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

echo "Creating the '${BASEDIR}/logs' folder"
mkdir -p ${BASEDIR}/logs

echo "Copying the JVM crash log files (+ heapdump) into ${BASEDIR}/logs"
cp ${BASEDIR}/hs_err_pid*.log ${BASEDIR}/logs/ || true
cp ${BASEDIR}/java-heap* ${BASEDIR}/logs/ || true

LIBFFI_FOLDER=graal/truffle/mxbuild/linux-amd64/src/libffi
echo "Copying the log files in ${BASEDIR}/${LIBFFI_FOLDER} into ${BASEDIR}/logs/${LIBFFI_FOLDER}"
mkdir -p ${BASEDIR}/logs/${LIBFFI_FOLDER}
cp ${BASEDIR}/${LIBFFI_FOLDER}/libffi*.log ${BASEDIR}/logs/${LIBFFI_FOLDER} || true

echo "Copying the strace log files in /tmp/ into ${BASEDIR}/logs/"
cp /tmp/strace-graal-compiler*.logs ${BASEDIR}/logs/ || true

for logFile in $(find . -type f -name "*.log" -o -name "*.logs" || true); do
	echo "Logfile collected: ${logFile}"
	PATH_TO_LOG_FILE=$(dirname ${logFile})
	DESTINATION_FOLDER="${BASEDIR}/logs/${PATH_TO_LOG_FILE}"
	mkdir -p "${DESTINATION_FOLDER}"
	cp -f "${logFile}" "${DESTINATION_FOLDER}"
done