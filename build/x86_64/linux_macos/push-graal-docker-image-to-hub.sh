#!/bin/bash

set -e
set -u
set -o pipefail

USER_NAME=${USER_NAME:-neomatrix369}
GRAAL_DOCKER_IMAGE="${USER_NAME}/graal-jdk8"

docker login --username=${USER_NAME}

IMAGE_ID=$(docker images graal-jdk8 -q | head -n1 || true)

if [[ -z "${IMAGE_ID}" ]]; then
    echo "Docker image 'graal-jdk8' not found in the local repository"
    exit 1
else
    docker tag ${IMAGE_ID} ${GRAAL_DOCKER_IMAGE}:latest

    docker push ${GRAAL_DOCKER_IMAGE}
fi
