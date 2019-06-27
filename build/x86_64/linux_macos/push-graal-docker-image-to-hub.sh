#!/bin/bash

set -e
set -u
set -o pipefail

if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  read -p "Docker username (must exist on Docker Hub): " DOCKER_USER_NAME
fi

if [[ -z ${IMAGE_VERSION:-""} ]]; then
  read -p "Enter a version number for this build, for e.g. use Python version if relevant, python-2.7 or python-3.7, otherwise it defaults to 'latest': " IMAGE_VERSION
fi

IMAGE_NAME=${IMAGE_NAME:-graalvm-suite-jdk8:${IMAGE_VERSION}}
GRAAL_DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

docker login --username=${DOCKER_USER_NAME}

IMAGE_ID=$(docker images ${IMAGE_NAME} -q | head -n1 || true)

if [[ -z "${IMAGE_ID}" ]]; then
    echo "Docker image '${IMAGE_NAME}' not found in the local repository"
    exit 1
else
    set -x
    docker tag ${IMAGE_ID} ${GRAAL_DOCKER_FULL_TAG_NAME}
    docker push ${GRAAL_DOCKER_FULL_TAG_NAME}
    set +x
fi