ARG JDK_PYTHON_BASE_IMAGE_TAG
FROM ${JDK_PYTHON_BASE_IMAGE_TAG}

FROM buildpack-deps:stretch-scm

# Install Java 8
COPY --from=0 /opt/java/openjdk/ /opt/java/openjdk/

ENV JAVA_HOME=/opt/java/openjdk/
ENV PATH=${JAVA_HOME}/bin:${PATH}
RUN echo "PATH=${PATH}"

RUN java -version

RUN echo "JAVA_HOME=${JAVA_HOME}"
ENV JAVA_8_HOME="${JAVA_HOME}"
RUN echo "JAVA_8_HOME=${JAVA_8_HOME}"

COPY osDependencies.sh /osDependencies.sh
RUN /osDependencies.sh

ARG MAKE_VERSION
COPY installMake.sh installMake.sh
RUN ./installMake.sh ${MAKE_VERSION}

ARG LLVM_VERSION
COPY installLLVM.sh installLLVM.sh
RUN ./installLLVM.sh ${LLVM_VERSION}

ARG RUBY_VERSION
COPY installRuby.sh installRuby.sh
RUN ./installRuby.sh ${RUBY_VERSION}

COPY sysctl.conf /etc/sysctl.conf

ENV LLVM_HOME /opt/clang+llvm-${LLVM_VERSION}.0-x86_64-linux-gnu-ubuntu-16.04
ENV RUBY_HOME /usr/local/rvm/rubies/ruby-${RUBY_VERSION}
ENV PATH      ${JAVA_HOME}/bin:${LLVM_HOME}/bin:${RUBY_HOME}/bin:${PATH}

RUN echo "export JAVA_HOME=${JAVA_HOME}" >> ${HOME_DIR}/.bashrc
RUN echo "export PATH=${JAVA_HOME}/bin:${LLVM_HOME}/bin:${RUBY_HOME}/bin:${PATH}" >> ${HOME_DIR}/.bashrc

RUN rm -r /var/lib/apt/lists/* || true
RUN rm /*.tar.xz || true
RUN rm /*.tar.gz || true

RUN java -version  || true
RUN make -version  || true
RUN python --version  || true
RUN ls /opt/clang+llvm-${LLVM_VERSION}.0-x86_64-linux-gnu-ubuntu-16.04*  || true
RUN ls /opt/clang+llvm-${LLVM_VERSION}.0-x86_64-linux-gnu-ubuntu-16.04/bin/*  || true
RUN opt -version  || true
RUN clang --version  || true
RUN ruby --version  || true

ARG USER_IN_CONTAINER
ENV HOME_DIR /home/${USER_IN_CONTAINER}
RUN useradd --create-home --shell /bin/bash ${USER_IN_CONTAINER} || true
USER $USER_IN_CONTAINER
WORKDIR ${HOME_DIR}