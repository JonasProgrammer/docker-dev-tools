ARG BASE_IMAGE=jonasprogrammer/dev-tools:clang
FROM ${BASE_IMAGE}

RUN conan install --build missing boost/1.69.0@conan/stable \
 && conan install --build missing -o boost:shared=False boost/1.69.0@conan/stable \
 && conan install --build missing Catch2/2.6.1@catchorg/stable \
 && conan install --build missing jsonformoderncpp/3.5.0@vthiery/stable \
 && conan install --build missing -o boost:shared=False -o boost:asio_no_deprecated=True boost/1.69.0@conan/stable \
 && conan install --build missing -o boost:shared=False -o boost:asio_no_deprecated=True -o boost:without_math=True -o boost:without_wave=True -o boost:without_container=True -o boost:without_contract=True -o boost:without_exception=True -o boost:without_graph=True -o boost:without_iostreams=True -o boost:without_locale=True -o boost:without_log=True -o boost:without_program_options=True -o boost:without_random=True -o boost:without_regex=True -o boost:without_mpi=True -o boost:without_serialization=True -o boost:without_coroutine=True -o boost:without_fiber=True -o boost:without_context=True -o boost:without_timer=True -o boost:without_thread=True -o boost:without_chrono=True -o boost:without_atomic=True -o boost:without_filesystem=True -o boost:without_graph_parallel=True -o boost:without_python=True -o boost:without_stacktrace=True -o boost:without_test=True -o boost:without_type_erasure=True boost/1.69.0@conan/stable
