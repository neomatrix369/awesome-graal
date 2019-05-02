#!/bin/bash

set -e
set -u
set -o pipefail

MAKE_VERSION=${1:-4.2.1}
MAKE_ARTIFACT_NAME=make-${MAKE_VERSION}
MAKE_ARTIFACT="${MAKE_ARTIFACT_NAME}.tar.gz"

if [[ ! -f "${MAKE_ARTIFACT}" ]]; then
	echo "Downloading ${MAKE_ARTIFACT}, since it's not found"
	wget https://ftp.gnu.org/gnu/make/${MAKE_ARTIFACT}
else
	echo "${MAKE_ARTIFACT} already exists"
fi

if [[ ! -d "${MAKE_ARTIFACT_NAME}" ]]; then
    echo "Unpacking ${MAKE_ARTIFACT_NAME}"
	tar xvzf ${MAKE_ARTIFACT}
else
    echo "${MAKE_ARTIFACT_NAME} already unpacked"
fi

cd ${MAKE_ARTIFACT_NAME}

echo "Replacing the line to fix the __alloc issue reported previously"
sed -i -- 's/_GNU_GLOB_INTERFACE_VERSION \=\= GLOB_INTERFACE_VERSION/_GNU_GLOB_INTERFACE_VERSION \>\= GLOB_INTERFACE_VERSION/g' glob/glob.c

echo "Running configure for make"
./configure

echo "Building make"
make

echo "Installing make"
make install
