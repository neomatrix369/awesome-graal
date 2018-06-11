#!/bin/bash

set -e
set -u
set -o pipefail

DEBUG=${DEBUG:-""}

DOCKER_IMAGE="graal-jdk8:latest"
CONTAINER_HOME_DIR="/home/graal"

if [[ "${DEBUG}" = "true" ]]; then
    DEBUG_MODE_ARGS="--interactive --tty --entrypoint /bin/bash"
else
    DEBUG_MODE_ARGS="--entrypoint ${CONTAINER_HOME_DIR}/native-build.sh"
fi

docker build -t ${DOCKER_IMAGE} .
docker run                           \
       ${DEBUG_MODE_ARGS}            \
       --rm                          \
       --volume $(pwd):${CONTAINER_HOME_DIR}  \
       ${DOCKER_IMAGE}

