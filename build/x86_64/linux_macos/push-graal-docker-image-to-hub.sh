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
  read -p "Docker username (must exist on Docker Hub): " DOCKER_USER_NAME
fi

if [[ -z ${IMAGE_VERSION:-""} ]]; then
  read -p "Enter a version number for this build, for e.g. use Python version if relevant, python-2.7 or python-3.7, otherwise it defaults to 'latest': " IMAGE_VERSION
fi

IMAGE_NAME=${IMAGE_NAME:-graal-jdk8}
IMAGE_VERSION=${IMAGE_VERSION:-latest}
GRAAL_DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

docker login --username=${DOCKER_USER_NAME}

IMAGE_ID=$(docker images ${IMAGE_NAME} -q | head -n1 || true)

if [[ -z "${IMAGE_ID}" ]]; then
    echo "Docker image '${IMAGE_NAME}' not found in the local repository"
    exit 1
else
    set -x
    docker tag ${IMAGE_ID} ${GRAAL_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}
    docker push ${GRAAL_DOCKER_FULL_TAG_NAME}
    set +x
fi
