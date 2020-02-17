ARG BASE_IMAGE=python:3-slim-buster
FROM ${BASE_IMAGE} AS jp-builder-base-image

ARG CMAKE_VERSION=3.16
ARG CMAKE_FULL_VERSION=${CMAKE_VERSION}.4
ARG CMAKE_DOWNLOAD=https://github.com/Kitware/CMake/releases/download/v${CMAKE_FULL_VERSION}/cmake-${CMAKE_FULL_VERSION}-Linux-x86_64.tar.gz

ARG CONAN_VERSION=1.22
ARG CONAN_FULL_VERSION=${CONAN_VERSION}.2

ENV CMAKE_VERSION ${CMAKE_VERSION} 
ENV CMAKE_MODULE_PATH /usr/local/share/cmake-${CMAKE_VERSION}/Modules
ENV LD_LIBRARY_PATH /usr/local/lib

WORKDIR /usr/local

RUN echo ". /etc/profile.local" >>/etc/profile; vars="CMAKE_VERSION CMAKE_MODULE_PATH LD_LIBRARY_PATH"; for i in $vars; do echo $i=\"$(eval echo \$$i)\" >>/etc/profile.local; echo export $i >>/etc/profile.local; done \
 && apt-get update \
 && apt-get install --no-install-recommends -y curl xz-utils libtinfo5 libxml2 make ca-certificates \
                    $(apt-cache depends cmake|grep Depends|grep -iv cmake|cut -d ':' -f 2) \
 && rm -rf /var/lib/apt/lists/* \
 && curl -Lo - ${CMAKE_DOWNLOAD} | tar xz --strip-components=1 \
 && pip install conan==${CONAN_FULL_VERSION} \
 && adduser --gecos '' --no-create-home --home /usr/local/src --disabled-password --disabled-login build-dev \
 && mkdir -p /usr/local/src && chown -R build-dev:build-dev /usr/local/src

USER build-dev
WORKDIR /usr/local/src

CMD ["/bin/bash"]

FROM jp-builder-base-image AS jp-builder-llvm
USER root

ARG LLVM_VERSION=10

RUN apt-get update \
 && apt-get install --no-install-recommends -y gnupg \
 && echo "deb http://apt.llvm.org/buster/ llvm-toolchain-buster-${LLVM_VERSION} main" > /etc/apt/sources.list.d/llvm.list \
 && curl -Lo - https://apt.llvm.org/llvm-snapshot.gpg.key| apt-key add - \
 && apt-get update \
 && apt-get install -y --no-install-recommends clang-tools-${LLVM_VERSION} clang-${LLVM_VERSION} clangd-${LLVM_VERSION} libc++-${LLVM_VERSION}-dev libc++abi-${LLVM_VERSION}-dev libomp-${LLVM_VERSION}-dev lld-${LLVM_VERSION} lldb-${LLVM_VERSION} \
 && rm -rf /var/lib/apt/lists/*

ENV CC=clang-${LLVM_VERSION} CXX=clang++-${LLVM_VERSION} CXXFLAGS=-stdlib=libc++

RUN conan profile new --detect default && conan profile update settings.compiler.libcxx=libc++ default

USER build-dev

FROM jp-builder-llvm AS jp-builder-llvm-ssh
USER root

RUN apt-get update \
 && apt-get install -y --no-install-recommends openssh-server \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /run/sshd \
 && sed -e 's/^X11.$/#\0/g' \
        -e 's/^#\?X11Forwarding.*$/X11Forwarding no/g' \
        -e 's/^#\?PasswordAuthentication.*$/PasswordAuthentication no/g' \
        -e 's/^#\?PermitRootLogin.*$/PermitRootLogin no/g' \
        -e 's/^#\?AllowTcpForwarding.*$/AllowTcpForwarding no\n/g'\
        -i /etc/ssh/sshd_config

COPY entrypoint.sh /entrypoint.sh

EXPOSE 22

RUN mkdir -p .ssh && chmod 700 .ssh && chown build-dev:build-dev .ssh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
