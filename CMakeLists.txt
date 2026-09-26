cmake_minimum_required(VERSION 3.10)

# The addon is an ordinary CMake project: config.cmake of build_tools computes
# the build environment (platform, architecture, compiler, artifact directory)
# before project() runs, which is what detects the compiler.

include(fib-addon/build_tools/cmake/config.cmake)

get_filename_component(name ${CMAKE_CURRENT_SOURCE_DIR} NAME)
project(${name})

file(GLOB_RECURSE src_list "${PROJECT_SOURCE_DIR}/nodejieba/lib/*.c*")

include_directories("${PROJECT_SOURCE_DIR}/nodejieba/deps")

include(fib-addon/common.cmake)
