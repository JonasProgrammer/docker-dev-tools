ARG BASE_IMAGE=jonasprogrammer/dev-tools:base
FROM ${BASE_IMAGE}

ARG CLANG_VERSION=7.0
ARG CLANG_FULL_VERSION=${CLANG_VERSION}.1
ARG CLANG_FLAVOUR=ubuntu-18.04
ARG CLANG_DOWNLOAD=http://releases.llvm.org/${CLANG_FULL_VERSION}/clang+llvm-${CLANG_FULL_VERSION}-x86_64-linux-gnu-${CLANG_FLAVOUR}.tar.xz

ENV CLANG_MAJOR=${CLANG_MAJOR}
ENV CLANG_VERSION=${CLANG_VERSION}

ENV CXXFLAGS="-stdlib=libc++"

USER root

RUN apt-get update && apt-get install --no-install-recommends -y curl libc++-dev && rm -rf /var/lib/apt/lists/* \
 && cd /usr/local \
 && curl -L ${CLANG_DOWNLOAD} | tar xvJ --strip-components=1 \
 && ln -s /usr/local/bin/lld /usr/local/bin/ld

USER build-dev

RUN mkdir -p .conan/profiles \
 && printf "[settings]\nos=Linux\nos_build=Linux\narch=x86_64\narch_build=x86_64\ncompiler=clang\ncompiler.version=${CLANG_VERSION}\ncompiler.libcxx=libc++\nbuild_type=Release\n[options]\n[build_requires]\n[env]\n" > ~/.conan/profiles/default

CMD ["/bin/bash"]