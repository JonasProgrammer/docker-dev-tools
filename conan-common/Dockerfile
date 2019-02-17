ARG BASE_IMAGE=jonasprogrammer/dev-tools:clang
FROM ${BASE_IMAGE}

RUN conan install --build missing \
    boost/1.69.0@conan/stable \
    Catch2/2.6.1@catchorg/stable