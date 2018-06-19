#!/bin/bash

set -e
set -u
set -o pipefail

LLVM_VERSION=${1:-6.0}

echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-${LLVM_VERSION} main" >> /etc/apt/sources.list.d/llvm.org.list
echo "deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial-${LLVM_VERSION} main" >> /etc/apt/sources.list.d/llvm.org.list

wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -

sudo apt-get update && \
    apt-get install -y \
    clang-${LLVM_VERSION} clang-tools-${LLVM_VERSION} clang-${LLVM_VERSION}-doc \
    libclang-common-${LLVM_VERSION}-dev libclang-${LLVM_VERSION}-dev libclang1-${LLVM_VERSION} \ 
    libllvm6.0 lldb-${LLVM_VERSION} llvm-${LLVM_VERSION} llvm-${LLVM_VERSION}-dev \
    llvm-${LLVM_VERSION}-doc llvm-${LLVM_VERSION}-examples llvm-${LLVM_VERSION}-runtime \
    clang-format-${LLVM_VERSION} python-clang-${LLVM_VERSION} lld-${LLVM_VERSION} libfuzzer-${LLVM_VERSION}-dev libc++-dev

echo ">>> Warning: Could not find these packages libllvm-${LLVM_VERSION}-ocaml-dev lldb-${LLVM_VERSION}-dev, even though mentioned on https://apt.llvm.org/ <<<"
