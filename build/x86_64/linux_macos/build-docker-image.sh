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

if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  read -p "Docker username (must exist on Docker Hub): " INPUT_DOCKER_USER_NAME
  export DOCKER_USER_NAME=${INPUT_DOCKER_USER_NAME}
fi

echo ""
echo "* Building base docker image ${DOCKER_USER_NAME}/${JDK_PYTHON_BASE_IMAGE_TAG}"
echo ""

CURRENT_DIR=$(dirname "$0")
echo "* Fetching docker image ${DOCKER_USER_NAME}/${JDK_PYTHON_BASE_IMAGE_TAG} from Docker Hub"
docker pull ${DOCKER_USER_NAME}/${JDK_PYTHON_BASE_IMAGE_TAG} || true
docker build \
            -t ${DOCKER_USER_NAME}/${JDK_PYTHON_BASE_IMAGE_TAG}    \
            --build-arg JDK_BASE_IMAGE_TAG=${JDK_BASE_IMAGE_TAG}   \
            -f ${CURRENT_DIR}/Dockerfile-python-${PYTHON_VERSION:-2.7} .

echo ""
echo "* Fetching docker image ${DOCKER_USER_NAME}/${DOCKER_IMAGE_TAG} from Docker Hub"
docker pull ${DOCKER_USER_NAME}/${DOCKER_IMAGE_TAG} || true
echo ""
echo "* Building docker image ${DOCKER_USER_NAME}/${DOCKER_IMAGE_TAG}, inheriting from base image ${DOCKER_USER_NAME}/${JDK_PYTHON_BASE_IMAGE_TAG}"
echo ""

docker build \
            -t ${DOCKER_USER_NAME}/${DOCKER_IMAGE_TAG} \
            --build-arg USER_IN_CONTAINER=${USER_IN_CONTAINER}                 \
            --build-arg GRAAL_JVMCI_8_TAG=${GRAAL_JVMCI_8_TAG}                 \
            --build-arg JDK_PYTHON_BASE_IMAGE_TAG=${DOCKER_USER_NAME}/${JDK_PYTHON_BASE_IMAGE_TAG} \
            --build-arg MAKE_VERSION=${MAKE_VERSION}                           \
            --build-arg PYTHON_VERSION=${PYTHON_VERSION}                       \
            --build-arg LLVM_VERSION=${LLVM_VERSION}                           \
            --build-arg RUBY_VERSION=${RUBY_VERSION}                           \
            -f ${CURRENT_DIR}/Dockerfile .