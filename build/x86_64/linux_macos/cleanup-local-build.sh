#!/usr/bin/env bash

set -e
set -u
set -o pipefail

DEPENDENCIES="graal graal-jvmci-8 jdk8-with-graal mx make-3*.tar.gz make-3*"

echo "Removing build tooling and dependencies: ${DEPENDENCIES}"
rm -fr ${DEPENDENCIES}
