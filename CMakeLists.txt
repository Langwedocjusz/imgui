cmake_minimum_required(VERSION 3.16.3)

project(imgui)

option(IMGUI_BACKEND_GLFW "Includes glfw backend in compiled sources." OFF)

option(IMGUI_BACKEND_OPENGL "Includes OpenGL backend in compiled sources." OFF)
option(IMGUI_BACKEND_VULKAN "Includes Vulkan backend in compiled sources." OFF)

add_library(${PROJECT_NAME})

file(GLOB headers *.h)
file(GLOB sources *.cpp)

set(implFiles)

if(IMGUI_BACKEND_GLFW)
    list(APPEND implFiles backends/imgui_impl_glfw.cpp)
endif()

if(IMGUI_BACKEND_OPENGL)
    list(APPEND implFiles backends/imgui_impl_opengl3.cpp)
endif()

if(IMGUI_BACKEND_VULKAN)
    list(APPEND implFiles backends/imgui_impl_vulkan.cpp)
endif()

target_include_directories(${PROJECT_NAME} PUBLIC . ./backends)

target_sources(${PROJECT_NAME} PRIVATE ${headers} ${sources} ${implFiles})