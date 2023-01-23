cmake_minimum_required(VERSION 3.21 FATAL_ERROR)

project(work.hpp
    VERSION "0.0.1"
    DESCRIPTION "BlackMATov Workspace"
    HOMEPAGE_URL "https://github.com/blackmatov/work.hpp"
    LANGUAGES CXX)

option(WORK_HPP_NO_EXCEPTIONS "Don't use exceptions" OFF)
option(WORK_HPP_NO_RTTI "Don't use RTTI" OFF)

#
# library
#

file(GLOB_RECURSE WORK_HPP_HEADERS "headers/*.hpp")
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${WORK_HPP_HEADERS})

add_library(${PROJECT_NAME} INTERFACE ${WORK_HPP_HEADERS})
add_library(work.hpp::work.hpp ALIAS ${PROJECT_NAME})

target_compile_features(${PROJECT_NAME} INTERFACE
    cxx_std_20)

target_include_directories(${PROJECT_NAME} INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/headers>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

target_compile_definitions(${PROJECT_NAME} INTERFACE
    $<$<BOOL:${WORK_HPP_NO_EXCEPTIONS}>:WORK_HPP_NO_EXCEPTIONS>
    $<$<BOOL:${WORK_HPP_NO_RTTI}>:WORK_HPP_NO_RTTI>)

find_package(Threads REQUIRED)
target_link_libraries(${PROJECT_NAME} INTERFACE Threads::Threads)

#
# develop
#

if(PROJECT_IS_TOP_LEVEL)
    add_subdirectory(develop)
endif()
