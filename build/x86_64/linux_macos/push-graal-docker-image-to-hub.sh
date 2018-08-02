#!/bin/bash

set -e
set -u
set -o pipefail

USER_NAME=${USER_NAME:-neomatrix369}
IMAGE_NAME=${IMAGE_NAME:-graal-jdk8}
IMAGE_VERSION=${IMAGE_VERSION:-latest}
GRAAL_DOCKER_FULL_TAG_NAME="${USER_NAME}/${IMAGE_NAME}"

docker login --username=${USER_NAME}

IMAGE_ID=$(docker images ${IMAGE_NAME} -q | head -n1 || true)

if [[ -z "${IMAGE_ID}" ]]; then
    echo "Docker image '${IMAGE_NAME}' not found in the local repository"
    exit 1
else
    docker tag ${IMAGE_ID} ${GRAAL_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}
    docker push ${GRAAL_DOCKER_FULL_TAG_NAME}
fi
