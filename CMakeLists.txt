cmake_minimum_required(VERSION 3.17 FATAL_ERROR)
include(cmake/GetDependencies.cmake)

#[[ library/executable properties start ]]
set(LIBRARY_NAME "Learn-CPP")
set(LIBRARY_VERSION "0.0.0.1")

set(BINARY_NAME ${LIBRARY_NAME}-bin)
set(STATIC_LIBRARY_NAME ${LIBRARY_NAME}-static)

set(TARGETS_LIST ${LIBRARY_NAME} ${STATIC_LIBRARY_NAME} ${BINARY_NAME})
#[[ library/executable properties end ]]

project(${LIBRARY_NAME} VERSION ${LIBRARY_VERSION})

configure_file("${CMAKE_CURRENT_SOURCE_DIR}/config/ProjectConfigurations.hpp.in" "${CMAKE_CURRENT_BINARY_DIR}/config/ProjectConfigurations.hpp")

#[[ SOURCE files section starts ]]
set(CPP_SOURCE_FILES
        "${CMAKE_CURRENT_SOURCE_DIR}/src/main/cpp/main.cpp")
#[[ SOURCE files section ends ]]

#[[ Libraries and Executables generation section starts ]]
add_library(${LIBRARY_NAME} SHARED ${CPP_SOURCE_FILES})
add_library(${STATIC_LIBRARY_NAME} STATIC ${CPP_SOURCE_FILES})
add_executable(${BINARY_NAME} ${CPP_SOURCE_FILES})

target_link_libraries(${BINARY_NAME} ${LIBRARY_NAME})
#[[ Libraries and Executables generation section ends ]]

#[[ HEADER files section starts ]]
foreach (target_item ${TARGETS_LIST})
    display_message("Wrapping up target: ${target_item}")
    set_target_properties(${target_item} PROPERTIES VERSION ${LIBRARY_VERSION})
    if (${target_item} MATCHES ${BINARY_NAME})
        set_target_properties(${target_item} PROPERTIES OUTPUT_NAME ${LIBRARY_NAME})
    endif ()
    target_include_directories(${target_item} PUBLIC
            $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/config>
            $<INSTALL_INTERFACE:include>
            PRIVATE src/main/includes)
endforeach ()
#[[ HEADER files section ends ]]
