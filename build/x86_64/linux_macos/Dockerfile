ARG JDK_PYTHON_BASE_IMAGE_TAG
FROM ${JDK_PYTHON_BASE_IMAGE_TAG}

FROM buildpack-deps:stretch-scm

# Install Java 8
COPY --from=0 /opt/java/openjdk/ /opt/java/openjdk/

ENV JAVA_HOME=/opt/java/openjdk/
ENV PATH=${JAVA_HOME}/bin:${PATH}

RUN echo "JAVA_HOME=${JAVA_HOME}"
RUN echo "PATH=${PATH}"

RUN java -version
RUN echo "JAVA_HOME=${JAVA_HOME}"
ENV JAVA_8_HOME="${JAVA_HOME}"
RUN echo "JAVA_8_HOME=${JAVA_8_HOME}"

COPY osDependencies.sh /osDependencies.sh
RUN  /bin/bash -l -c "./osDependencies.sh"

ARG  MAKE_VERSION
COPY installMake.sh /installMake.sh
RUN  /bin/bash -l -c "./installMake.sh ${MAKE_VERSION}"

ARG     USER_IN_CONTAINER
ENV     HOME_DIR /home/${USER_IN_CONTAINER}
RUN     useradd --create-home --shell /bin/bash ${USER_IN_CONTAINER} || true
USER    ${USER_IN_CONTAINER}
WORKDIR ${HOME_DIR}

RUN echo "export JAVA_HOME=${JAVA_HOME}" >> ${HOME_DIR}/.bashrc
RUN echo "export PATH=${JAVA_HOME}/bin:${PATH}" >> ${HOME_DIR}/.bashrc

RUN java -version
RUN make -version
RUN python --version