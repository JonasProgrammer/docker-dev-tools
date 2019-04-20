ARG BASE_IMAGE=python:slim
FROM ${BASE_IMAGE}

ARG CMAKE_VERSION=3.13
ARG CMAKE_FULL_VERSION=${CMAKE_VERSION}.4
ARG CMAKE_DOWNLOAD=https://github.com/Kitware/CMake/releases/download/v${CMAKE_FULL_VERSION}/cmake-${CMAKE_FULL_VERSION}-Linux-x86_64.tar.gz

ARG CONAN_VERSION=1.12
ARG CONAN_FULL_VERSION=${CONAN_VERSION}.2

ENV CMAKE_VERSION ${CMAKE_VERSION} 
ENV CMAKE_MODULE_PATH /usr/local/share/cmake-${CMAKE_VERSION}/Modules
ENV LD_LIBRARY_PATH /usr/local/lib

WORKDIR /usr/local

RUN vars="CMAKE_VERSION CMAKE_MODULE_PATH LD_LIBRARY_PATH"; for i in $vars; do echo $i=\"$(eval echo \$$i)\" >>/etc/profile.local; echo export $i >>/etc/profile.local; done \
 && apt-get update && apt-get install --no-install-recommends -y curl xz-utils libc6-dev libgcc-6-dev libxml2 make binutils gdb && rm -rf /var/lib/apt/lists/* \
 && curl -L ${CMAKE_DOWNLOAD} | tar xvz --strip-components=1 \
 && pip install conan==${CONAN_FULL_VERSION} \
\
 && adduser --gecos '' --no-create-home --home /usr/local/src --disabled-password --disabled-login build-dev \
 && mkdir -p /usr/local/src && chown -R build-dev:build-dev /usr/local/src

USER build-dev
WORKDIR /usr/local/src

CMD ["/bin/bash"]
