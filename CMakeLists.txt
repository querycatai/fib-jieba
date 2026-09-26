cmake_minimum_required(VERSION 3.10)

# The addon is an ordinary CMake project: config.cmake of build_tools computes
# the build environment (platform, architecture, compiler, artifact directory)
# before project() runs, which is what detects the compiler.

include(fib-addon/build_tools/cmake/config.cmake)

get_filename_component(name ${CMAKE_CURRENT_SOURCE_DIR} NAME)
project(${name})

file(GLOB_RECURSE src_list "${PROJECT_SOURCE_DIR}/nodejieba/lib/*.c*")

include_directories("${PROJECT_SOURCE_DIR}/nodejieba/deps")

# nodejieba vendors limonp, which still uses the C++03 binder adaptors:
# std::ptr_fun and std::bind2nd were removed in C++17, std::not1 in C++20.
# libc++ - the standard library of Apple and of the Android NDK - follows the
# removals, while libstdc++ and MSVC keep the names.  libc++ restores them for
# code like this when the macros are defined, so the vendored headers do not
# have to be patched.
if(BUILD_OS STREQUAL "Android" OR CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin")
    add_definitions(-D_LIBCPP_ENABLE_CXX17_REMOVED_FEATURES
        -D_LIBCPP_ENABLE_CXX20_REMOVED_FEATURES)
endif()

include(fib-addon/common.cmake)
