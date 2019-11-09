ARG BASE_IMAGE=jonasprogrammer/dev-tools:clang
FROM ${BASE_IMAGE}

ARG BOOST_VERSION=1.71.0
ARG CATCH_VERSION=2.10.2
ARG NLJSON_VERSION=3.7.0

RUN conan install --build missing boost/${BOOST_VERSION}@conan/stable \
 && conan install --build missing -o boost:shared=False boost/${BOOST_VERSION}@conan/stable \
 && conan install --build missing Catch2/${CATCH_VERSION}@catchorg/stable \
 && conan install --build missing jsonformoderncpp/${NLJSON_VERSION}@vthiery/stable
