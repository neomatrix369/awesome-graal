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

HOST_OUTPUT_DIR="$(pwd)/graalvm-via-docker"
mkdir -p "${HOST_OUTPUT_DIR}"

CONTAINER_SCRIPTS_DIR="${CONTAINER_HOME_DIR}/scripts"
CONTAINER_OUTPUT_DIR="${CONTAINER_HOME_DIR}/output"
docker build -t ${DOCKER_IMAGE_TAG} .
docker run                               \
       ${DEBUG_MODE_ARGS}                \
       --rm                              \
       --env JAVA_VERSION=${JDK_VERSION} \
       --env OUTPUT_DIR=${CONTAINER_OUTPUT_DIR}             \
       --volume $(pwd):${CONTAINER_SCRIPTS_DIR}             \
       --volume ${HOST_OUTPUT_DIR}:${CONTAINER_OUTPUT_DIR}  \
       ${DOCKER_IMAGE_TAG}

