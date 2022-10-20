cmake_minimum_required(VERSION 3.16.3)

project(imgui)

add_library(${PROJECT_NAME})

file(GLOB headers *.h)
file(GLOB sources *.cpp)

target_include_directories(${PROJECT_NAME} PUBLIC . ./backends)
target_sources(${PROJECT_NAME} PRIVATE ${headers} ${sources})
