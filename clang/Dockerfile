ARG BASE_IMAGE=jonasprogrammer/dev-tools:base

FROM ${BASE_IMAGE} AS base

ARG CLANG_VERSION=7.0
ARG CLANG_FULL_VERSION=${CLANG_VERSION}.1
ARG CLANG_FLAVOUR=ubuntu-18.04
ARG CLANG_DOWNLOAD=http://releases.llvm.org/${CLANG_FULL_VERSION}/clang+llvm-${CLANG_FULL_VERSION}-x86_64-linux-gnu-${CLANG_FLAVOUR}.tar.xz
ARG CLANG_LLVM_DOWNLOAD=http://releases.llvm.org/${CLANG_FULL_VERSION}/llvm-${CLANG_FULL_VERSION}.src.tar.xz
ARG CLANG_LIBCXX_DOWNLOAD=http://releases.llvm.org/${CLANG_FULL_VERSION}/libcxx-${CLANG_FULL_VERSION}.src.tar.xz
ARG CLANG_LIBCXXABI_DOWNLOAD=http://releases.llvm.org/${CLANG_FULL_VERSION}/libcxxabi-${CLANG_FULL_VERSION}.src.tar.xz

ENV CLANG_VERSION=${CLANG_VERSION}

ENV CXXFLAGS="-stdlib=libc++"

USER root

RUN cd /usr/local \
 && curl -L ${CLANG_DOWNLOAD} | tar xvJ --strip-components=1 \
 && ln -s /usr/local/bin/lld /usr/local/bin/ld

RUN mkdir -p /usr/src/llvm && cd /usr/src/llvm \
 && curl -L ${CLANG_LLVM_DOWNLOAD} | tar xvJ --strip-components=1 \
 && mkdir -p projects/libcxx && cd projects/libcxx \
 && curl -L ${CLANG_LIBCXX_DOWNLOAD} | tar xvJ --strip-components=1 \
 && cd /usr/src/llvm \
 && mkdir -p projects/libcxxabi && cd projects/libcxxabi \
 && curl -L ${CLANG_LIBCXXABI_DOWNLOAD} | tar xvJ --strip-components=1

RUN cd /usr/src/llvm && mkdir -p libcxx-build \
 && cmake -S . -B libcxx-build -DCMAKE_INSTALL_PREFIX=/usr/local \
 && cd libcxx-build \
 && make cxx && make install-cxx && make install-cxxabi


FROM ${BASE_IMAGE}
USER root

ARG CLANG_VERSION=7.0
ENV CLANG_VERSION=${CLANG_VERSION}

ENV CXXFLAGS="-stdlib=libc++"

COPY --from=base /usr/local /usr/local-temp/

RUN cp -R /usr/local-temp/* /usr/local && rm -Rf /usr/local-temp && chown -R build-dev:build-dev /usr/local/src

USER build-dev
WORKDIR /usr/local/src
RUN mkdir -p .conan/profiles \
 && printf "[settings]\nos=Linux\nos_build=Linux\narch=x86_64\narch_build=x86_64\ncompiler=clang\ncompiler.version=${CLANG_VERSION}\ncompiler.libcxx=libc++\nbuild_type=Release\n[options]\n[build_requires]\n[env]\n" > ~/.conan/profiles/default
