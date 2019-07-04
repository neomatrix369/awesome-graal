#!/bin/bash

set -e
set -u
set -o pipefail

if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  read -p "Docker username (must exist on Docker Hub): " DOCKER_USER_NAME
fi

if [[ -z ${PYTHON_VERSION:-""} ]]; then
  read -p "Enter the specific python version number for this build, for e.g. use Python version if relevant, 2.7 or 3.7: " PYTHON_VERSION
fi
PYTHON_VERSION=${PYTHON_VERSION:-2.7}
IMAGE_VERSION="python-${PYTHON_VERSION}"

docker login --username=${DOCKER_USER_NAME}

push_image() {
	FULL_IMAGE_NAME="${1}:${2}"
	GRAAL_DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${FULL_IMAGE_NAME}"

	IMAGE_ID=$(docker images ${FULL_IMAGE_NAME} -q | head -n1 || true)

	if [[ -z "${IMAGE_ID}" ]]; then
	    echo "Docker image '${GRAAL_DOCKER_FULL_TAG_NAME}' not found in the local repository"
	    exit 1
	else
	    set -x
	    docker tag ${IMAGE_ID} ${GRAAL_DOCKER_FULL_TAG_NAME}
	    docker push ${GRAAL_DOCKER_FULL_TAG_NAME}
	    set +x
	fi
}

push_image jdk-python-base ${PYTHON_VERSION}
push_image graalvm-suite-jdk8 ${IMAGE_VERSION}