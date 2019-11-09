ARG BASE_IMAGE=jonasprogrammer/dev-tools:clang
FROM ${BASE_IMAGE}

ARG BOOST_VERSION=1.71.0
ARG CATCH_VERSION=2.10.2
ARG NLJSON_VERSION=3.7.0

RUN conan install --build missing boost/${BOOST_VERSION}@conan/stable \
 && conan install --build missing -o boost:shared=False boost/${BOOST_VERSION}@conan/stable \
 && conan install --build missing Catch2/${CATCH_VERSION}@catchorg/stable \
 && conan install --build missing jsonformoderncpp/${NLJSON_VERSION}@vthiery/stable \
 && conan install --build missing -o boost:shared=False -o boost:asio_no_deprecated=True boost/${BOOST_VERSION}@conan/stable \
 && conan install --build missing -o boost:shared=False -o boost:asio_no_deprecated=True -o boost:without_math=True -o boost:without_wave=True -o boost:without_container=True -o boost:without_contract=True -o boost:without_exception=True -o boost:without_graph=True -o boost:without_iostreams=True -o boost:without_locale=True -o boost:without_log=True -o boost:without_program_options=True -o boost:without_random=True -o boost:without_regex=True -o boost:without_mpi=True -o boost:without_serialization=True -o boost:without_coroutine=True -o boost:without_fiber=True -o boost:without_context=True -o boost:without_timer=True -o boost:without_thread=True -o boost:without_chrono=True -o boost:without_atomic=True -o boost:without_filesystem=True -o boost:without_graph_parallel=True -o boost:without_python=True -o boost:without_stacktrace=True -o boost:without_test=True -o boost:without_type_erasure=True boost/${BOOST_VERSION}@conan/stable
