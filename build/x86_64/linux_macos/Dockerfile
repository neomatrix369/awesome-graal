FROM adoptopenjdk/openjdk8:jdk8u152-b16

ARG LLVM_VERSION
ENV LLVM_VERSION 4.0

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

COPY installLLVM.sh /installLLVM.sh
RUN /bin/bash -l -c "./installLLVM.sh ${LLVM_VERSION}"

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
