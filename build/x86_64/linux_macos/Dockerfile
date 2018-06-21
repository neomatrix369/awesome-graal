ARG JDK_BASE_IMAGE_TAG
FROM adoptopenjdk/${JDK_BASE_IMAGE_TAG}

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
        libssl-dev \
    && apt-get autoremove \
    && apt-get clean

ARG MAKE_VERSION
COPY installMake.sh /installMake.sh
RUN /bin/bash -l -c "./installMake.sh ${MAKE_VERSION}"

ARG LLVM_VERSION
COPY installLLVM.sh /installLLVM.sh
RUN /bin/bash -l -c "./installLLVM.sh ${LLVM_VERSION}"

ARG RUBY_VERSION
COPY installRuby.sh /installRuby.sh
RUN /bin/bash -l -c "./installRuby.sh ${RUBY_VERSION}"

ARG USER_IN_CONTAINER
ENV HOME_DIR /home/${USER_IN_CONTAINER}
RUN useradd --create-home --shell /bin/bash ${USER_IN_CONTAINER} || true
USER $USER_IN_CONTAINER
WORKDIR ${HOME_DIR}

ENV JAVA_HOME /opt/java/openjdk/${JAVA_VERSION}
ENV LLVM_HOME /usr/lib/llvm-${LLVM_VERSION}
ENV RUBY_HOME /usr/local/rvm/rubies/ruby-${RUBY_VERSION}
ENV PATH      ${JAVA_HOME}/bin:${LLVM_HOME}/bin:${RUBY_HOME}/bin:${PATH}

RUN echo "export JAVA_HOME=${JAVA_HOME}" >> ${HOME_DIR}/.bashrc
RUN echo "export PATH=${JAVA_HOME}/bin:${LLVM_HOME}/bin:${RUBY_HOME}/bin:${PATH}" >> ${HOME_DIR}/.bashrc

RUN /bin/bash -l -c 'java -version'
RUN /bin/bash -l -c 'make -version'
RUN /bin/bash -l -c 'python --version'
RUN /bin/bash -l -c 'ls /usr/lib/llvm-${LLVM_VERSION}/bin/*'
RUN /bin/bash -l -c 'opt -version'
RUN /bin/bash -l -c 'clang --version'
RUN /bin/bash -l -c 'ruby --version'
