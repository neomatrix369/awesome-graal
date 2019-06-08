#!/usr/bin/env bash

set -e
set -u
set -o pipefail

source ${SCRIPTS_LIB_DIR}/utils.sh

BASEDIR=$1

echo "Creating the '${BASEDIR}/logs' folder"
mkdir -p ${BASEDIR}/logs

echo "Copying the JVM crash log files (+ heapdump) into ${BASEDIR}/logs"
cp ${BASEDIR}/hs_err_pid*.log ${BASEDIR}/logs/ || true
cp ${BASEDIR}/java-heap* ${BASEDIR}/logs/ || true

LIBFFI_FOLDER=graal/truffle/mxbuild/linux-amd64/src/libffi
echo "Copying the log files in ${BASEDIR}/${LIBFFI_FOLDER} into ${BASEDIR}/logs/${LIBFFI_FOLDER}"
mkdir -p ${BASEDIR}/logs/${LIBFFI_FOLDER}
cp ${BASEDIR}/${LIBFFI_FOLDER}/libffi*.log ${BASEDIR}/logs/${LIBFFI_FOLDER} || true