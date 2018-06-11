FROM openjdk

ENV JDK8_PATH /docker-java-home

ENV USER_IN_CONTAINER graal
ENV HOME_DIR /home/${USER_IN_CONTAINER}

RUN set -ex; \
    apt-get update \
    && apt-get upgrade -y \
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

RUN pip install -U "setuptools==3.4.1"
RUN pip install -U "pip==1.5.4"
RUN pip install -U "Mercurial==2.9.1"
RUN pip install -U "virtualenv==1.11.4"

RUN /bin/bash -l -c 'python --version'
RUN /bin/bash -l -c 'echo "***** pip version $(pip --version) *****"'
RUN /bin/bash -l -c 'echo "***** virtualenv version $(virtualenv --version) *****"'

ENV JAVA_HOME ${JDK8_PATH}
ENV PATH      ${JAVA_HOME}/bin:${PATH}

RUN useradd --create-home --shell /bin/bash $USER_IN_CONTAINER
USER $USER_IN_CONTAINER

RUN echo "export JAVA_HOME=${JDK8_PATH}" >> ${HOME_DIR}/.bashrc
RUN echo "export PATH=${JAVA_HOME}/bin:${PATH}" >> ${HOME_DIR}/.bashrc

WORKDIR ${HOME_DIR}
