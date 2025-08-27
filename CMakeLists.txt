CMAKE_MINIMUM_REQUIRED(VERSION 3.31)
PROJECT(pre_compile_performance_test)

SET(CMAKE_CXX_STANDARD 20)

SET(CMAKE_EXPORT_COMPILE_COMMANDS ON)

ADD_EXECUTABLE(standard main.cpp)

ADD_LIBRARY(pch_provider lib.cpp)

TARGET_PRECOMPILE_HEADERS(pch_provider
        PRIVATE precomp.hpp)

ADD_EXECUTABLE(precompiled main.cpp)

TARGET_PRECOMPILE_HEADERS(precompiled
        REUSE_FROM pch_provider)

ADD_EXECUTABLE(standard_freecad main_freecad.cpp)

ADD_LIBRARY(freecad_pch_provider lib.cpp)

TARGET_COMPILE_DEFINITIONS(freecad_pch_provider PRIVATE PreCompiled)
TARGET_PRECOMPILE_HEADERS(freecad_pch_provider
        PRIVATE precomp_freecad.hpp)

ADD_EXECUTABLE(precompiled_freecad main.cpp)

TARGET_COMPILE_DEFINITIONS(precompiled_freecad PRIVATE PreCompiled)
TARGET_PRECOMPILE_HEADERS(precompiled_freecad
        REUSE_FROM pch_provider)
