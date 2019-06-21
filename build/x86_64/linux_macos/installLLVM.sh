#!/bin/bash

set -e
set -u
set -o pipefail

if [[ "$(uname)" = "Darwin" ]]; then
  echo "MacOS specific steps"
  echo "Ensure you have the latest version of XCode installed or else you will be prompted to do so"
  brew install llvm@4

  echo "For compilers to find this software you may need to set (check for the correct path):"
  echo "LDFLAGS: -L/usr/local/opt/llvm@4/lib -Wl,-rpath,/usr/local/opt/llvm@4/lib"
  echo "CPPFLAGS: -I/usr/local/opt/llvm@4/include"

else 
  echo "Linux/Unix specific steps"  
  ### Note only version 5.0 and 6.0 are available at the time of creation of this script, see https://apt.llvm.org/
  LLVM_VERSION=${1:-6.0}

  if [ -f "/.dockerenv" ]; then
     echo "Running inside the container environment i.e. Docker"
     sudoCMD=""
     echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-${LLVM_VERSION} main" >> /etc/apt/sources.list.d/llvm.org.list
     echo "deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial-${LLVM_VERSION} main" >> /etc/apt/sources.list.d/llvm.org.list   
  else
     echo "Running in a real OS environment"
     sudoCMD="sudo"
     echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-${LLVM_VERSION} main" | sudo tee -a /etc/apt/sources.list.d/llvm.org.list
     echo "deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial-${LLVM_VERSION} main" | sudo tee -a /etc/apt/sources.list.d/llvm.org.list
  fi

  wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | ${sudoCMD} apt-key add -

  ${sudoCMD} apt-get update && \
      ${sudoCMD} apt-get install -y \
      clang-${LLVM_VERSION} clang-tools-${LLVM_VERSION} clang-${LLVM_VERSION}-doc && \
      ${sudoCMD} apt-get install -y \
      clang-format-${LLVM_VERSION} python-clang-${LLVM_VERSION} && \
      ${sudoCMD} apt-get install -y \
      libclang-common-${LLVM_VERSION}-dev libclang-${LLVM_VERSION}-dev libclang1-${LLVM_VERSION} && \
      ${sudoCMD} apt-get install -y \
      ldb-${LLVM_VERSION} llvm-${LLVM_VERSION} llvm-${LLVM_VERSION}-dev && \
      ${sudoCMD} apt-get install -y \
      llvm-${LLVM_VERSION}-doc llvm-${LLVM_VERSION}-examples llvm-${LLVM_VERSION}-runtime && \
      ${sudoCMD} apt-get install -y \
      lld-${LLVM_VERSION} libfuzzer-${LLVM_VERSION}-dev libc++-dev \
        && rm -r /var/lib/apt/lists/*

  echo ">>> Warning: Could not find these packages 'libllvm${LLVM_VERSION}', 'libllvm-${LLVM_VERSION}-ocaml-dev' and 'lldb-${LLVM_VERSION}-dev', even though mentioned on https://apt.llvm.org/ <<<"

  echo "Creating softlink for opt at /usr/bin/opt"
  ${sudoCMD} ln -fs "/usr/lib/llvm-${LLVM_VERSION}/bin/opt" /usr/bin/opt || true
fi
