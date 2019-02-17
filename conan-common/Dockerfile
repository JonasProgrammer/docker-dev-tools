ARG BASE_IMAGE=jonasprogrammer/dev-tools:clang
FROM ${BASE_IMAGE}

RUN conan install --build missing boost/1.69.0@conan/stable \
 && conan install --build missing -o boost:shared=false boost/1.69.0@conan/stable \
 && conan install --build missing Catch2/2.6.1@catchorg/stable \
 && conan install --build missing jsonformoderncpp/3.5.0@vthiery/stable \
 && conan install --build missing -o boost:shared=false -o boost:asio_no_deprecated=true boost/1.69.0@conan/stable \
 && conan install --build missing -o boost:shared=false -o boost:asio_no_deprecated=true -o boost:without_math=true -o boost:without_wave=true -o boost:without_container=true -o boost:without_contract=true -o boost:without_exception=true -o boost:without_graph=true -o boost:without_iostreams=true -o boost:without_locale=true -o boost:without_log=true -o boost:without_program_options=true -o boost:without_random=true -o boost:without_regex=true -o boost:without_mpi=true -o boost:without_serialization=true -o boost:without_coroutine=true -o boost:without_fiber=true -o boost:without_context=true -o boost:without_timer=true -o boost:without_thread=true -o boost:without_chrono=true -o boost:without_atomic=true -o boost:without_filesystem=true -o boost:without_graph_parallel=true -o boost:without_python=true -o boost:without_stacktrace=true -o boost:without_test=true -o boost:without_type_erasure=true boost/1.69.0@conan/stable
