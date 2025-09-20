cmake_minimum_required(VERSION 3.16.3)

project(imgui)

option(IMGUI_BACKEND_GLFW "Wether or not to include Glfw backend implementation. Requires linking agains Glfw." OFF)
option(IMGUI_BACKEND_VULKAN "Wether or not to include Vulkan backend implementation. Requires linking agains Vulkan." OFF)

add_library(${PROJECT_NAME})

file(GLOB headers *.h)
file(GLOB sources *.cpp)

if(IMGUI_BACKEND_VULKAN)
    file(GLOB gapi_backend backends/imgui_impl_vulkan.cpp)
endif(IMGUI_BACKEND_VULKAN)

if(IMGUI_BACKEND_GLFW)
    file(GLOB window_backend backends/imgui_impl_glfw.cpp)
endif(IMGUI_BACKEND_GLFW)

target_sources(${PROJECT_NAME} PRIVATE ${headers} ${sources} ${gapi_backend} ${window_backend})

if(UNIX AND NOT APPLE)
    find_package(X11 REQUIRED)
    target_link_libraries(imgui PRIVATE ${X11_LIBRARIES})
endif()

target_include_directories(${PROJECT_NAME} PUBLIC SYSTEM . ./backends)