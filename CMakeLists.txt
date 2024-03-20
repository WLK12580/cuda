cmake_minimum_required(VERSION 3.8)
project(CUDA_TEST)
enable_language(CUDA)
if(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
set(CMAKE_CUDA_ARCHITECTURES 70 75 80)
endif(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)

find_package(CUDA REQUIRED)

message(STATUS "cuda version: " ${CUDA_VERSION_STRING})
include_directories(${CUDA_INCLUDE_DIRS})

add_executable(cuda_test cuda_array.cu)
target_link_libraries(cuda_test ${CUDA_LIBRARIES})