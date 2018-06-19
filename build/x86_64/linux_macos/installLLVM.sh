#!/bin/bash

set -e
set -u
set -o pipefail

### Note only version 5.0 and 6.0 are available at the time of creation of this script, see https://apt.llvm.org/
LLVM_VERSION=6.0

if [ -f "/.dockerenv" ]; then
   echo "Running inside the container environment i.e. Docker"
   sudoCMD=""
else
   echo "Running in a real OS environment"
   sudoCMD="sudo"
fi

echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-${LLVM_VERSION} main" >> /etc/apt/sources.list.d/llvm.org.list
echo "deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial-${LLVM_VERSION} main" >> /etc/apt/sources.list.d/llvm.org.list

wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | ${sudoCMD} apt-key add -

${sudoCMD} apt-get update && \
    ${sudoCMD} apt-get install -y \
    clang-${LLVM_VERSION} clang-tools-${LLVM_VERSION} clang-${LLVM_VERSION}-doc \
    clang-format-${LLVM_VERSION} python-clang-${LLVM_VERSION} \
    libclang-common-${LLVM_VERSION}-dev libclang-${LLVM_VERSION}-dev libclang1-${LLVM_VERSION} \ 
    libllvm${LLVM_VERSION} lldb-${LLVM_VERSION} llvm-${LLVM_VERSION} llvm-${LLVM_VERSION}-dev \
    llvm-${LLVM_VERSION}-doc llvm-${LLVM_VERSION}-examples llvm-${LLVM_VERSION}-runtime \
    lld-${LLVM_VERSION} libfuzzer-${LLVM_VERSION}-dev libc++-dev

echo ">>> Warning: Could not find these packages libllvm-${LLVM_VERSION}-ocaml-dev lldb-${LLVM_VERSION}-dev, even though mentioned on https://apt.llvm.org/ <<<"
