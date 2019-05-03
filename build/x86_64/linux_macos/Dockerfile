ARG JDK_BASE_IMAGE_TAG
FROM ${JDK_BASE_IMAGE_TAG}

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

ENV JAVA_HOME /opt/java/openjdk/
ENV PATH      ${JAVA_HOME}/bin:${PATH}

RUN echo "export JAVA_HOME=${JAVA_HOME}" >> ${HOME_DIR}/.bashrc
RUN echo "export PATH=${JAVA_HOME}/bin:${PATH}" >> ${HOME_DIR}/.bashrc

RUN /bin/bash -l -c 'java -version'
RUN /bin/bash -l -c 'make -version'
RUN /bin/bash -l -c 'python --version'
