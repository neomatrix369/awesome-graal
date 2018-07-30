#!/bin/bash

set -e
set -u
set -o pipefail

echo "* Building docker image ${DOCKER_IMAGE_TAG}"

docker build \
            -t ${DOCKER_IMAGE_TAG} \
            --build-arg USER_IN_CONTAINER=${USER_IN_CONTAINER}   \
            --build-arg JAVA_VERSION=${JAVA_VERSION}             \
            --build-arg JDK_BASE_IMAGE_TAG=${JDK_BASE_IMAGE_TAG} \
            --build-arg MAKE_VERSION=${MAKE_VERSION}             \
            --build-arg LLVM_VERSION=${LLVM_VERSION}             \
            --build-arg RUBY_VERSION=${RUBY_VERSION} .

