FROM adoptopenjdk/openjdk8:jdk8u152-b16

ARG LLVM_VERSION
ENV LLVM_VERSION 6.0

RUN set -ex; \
    apt-get update \
    && apt-get install -y \
        build-essential \
        ca-certificates \
        gcc \
        git \
        libpq-dev \
        make \
        python-pip \
        python2.7 \
        python2.7-dev \
        ssh \
    && apt-get autoremove \
    && apt-get clean

COPY installMake382.sh /installMake382.sh 
RUN /bin/bash -l -c './installMake382.sh'

RUN echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-${LLVM_VERSION} main" >> /etc/apt/sources.list.d/llvm.org.list
RUN echo "deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial-${LLVM_VERSION} main" >> /etc/apt/sources.list.d/llvm.org.list

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

RUN apt-get update && \
    apt-get install -y \
    clang-${LLVM_VERSION} clang-tools-${LLVM_VERSION} clang-${LLVM_VERSION}-doc \
    libclang-common-${LLVM_VERSION}-dev libclang-${LLVM_VERSION}-dev libclang1-${LLVM_VERSION} \ 
    libllvm6.0 lldb-${LLVM_VERSION} llvm-${LLVM_VERSION} llvm-${LLVM_VERSION}-dev \
    llvm-${LLVM_VERSION}-doc llvm-${LLVM_VERSION}-examples llvm-${LLVM_VERSION}-runtime \
    clang-format-${LLVM_VERSION} python-clang-${LLVM_VERSION} lld-${LLVM_VERSION} libfuzzer-${LLVM_VERSION}-dev

RUN echo ">>> Warning: Could not find these packages libllvm-${LLVM_VERSION}-ocaml-dev lldb-${LLVM_VERSION}-dev, even though mentioned on https://apt.llvm.org/ <<<"

ENV USER_IN_CONTAINER graal
ENV HOME_DIR /home/${USER_IN_CONTAINER}

RUN useradd --create-home --shell /bin/bash $USER_IN_CONTAINER
USER $USER_IN_CONTAINER
WORKDIR ${HOME_DIR}

ENV JAVA_HOME /opt/java/openjdk/${JAVA_VERSION}
ENV LLVM_HOME /usr/lib/llvm-${LLVM_VERSION}
ENV PATH      ${JAVA_HOME}/bin:${LLVM_HOME}/bin:${PATH}

RUN echo "export JAVA_HOME=${JAVA_HOME}" >> ${HOME_DIR}/.bashrc
RUN echo "export PATH=${JAVA_HOME}/bin:${PATH}" >> ${HOME_DIR}/.bashrc
RUN echo "export PATH=${LLVM_HOME}/bin:${PATH}" >> ${HOME_DIR}/.bashrc

RUN /bin/bash -l -c 'java -version'
RUN /bin/bash -l -c 'make -version'
RUN /bin/bash -l -c 'python --version'
RUN /bin/bash -l -c 'ls /usr/lib/llvm-${LLVM_VERSION}/bin/*'
RUN /bin/bash -l -c 'opt -version'
RUN /bin/bash -l -c 'clang --version'

