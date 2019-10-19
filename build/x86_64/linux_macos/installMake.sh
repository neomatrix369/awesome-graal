#!/bin/bash

#
# Copyright 2019 Mani Sarkar
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
