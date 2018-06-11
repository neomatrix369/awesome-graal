#!/bin/bash

set -e
set -u
set -o pipefail

DEBUG=${DEBUG:-""}

JDK_VERSION="jdk8u172-b11"
DOCKER_IMAGE_TAG="graal-jdk8:latest"
CONTAINER_HOME_DIR="/home/graal"

if [[ "${DEBUG}" = "true" ]]; then
    DEBUG_MODE_ARGS="--interactive --tty --entrypoint /bin/bash"
else
    DEBUG_MODE_ARGS="--entrypoint ${CONTAINER_HOME_DIR}/scripts/native-build.sh"
fi

docker build -t ${DOCKER_IMAGE_TAG} .
docker run                               \
       ${DEBUG_MODE_ARGS}                \
       --rm                              \
       --env JAVA_VERSION=${JDK_VERSION} \
       --volume $(pwd):${CONTAINER_HOME_DIR}/scripts  \
       ${DOCKER_IMAGE_TAG}

