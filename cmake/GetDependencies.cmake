cmake_minimum_required(VERSION 3.17)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS "-pthread")

include(FetchContent)
include(CMakeParseArguments)

#[[
Parses provided dependencies file.

sample calls to this function:
parse_dependencies_file(IS_TEST DEPENDENCIES_FILE "${CMAKE_CURRENT_SOURCE_DIR}/config/dependencies.csv" LIBRARIES_PARSED ${LIBRARIES_PARSED})
                                               or
parse_dependencies_file(DEPENDENCIES_FILE "${CMAKE_CURRENT_SOURCE_DIR}/config/dependencies.csv" LIBRARIES_PARSED ${LIBRARIES_PARSED})

${LIBRARIES_PARSED} will be marked as parent scope item to be accessible from calling cmake.
]]
function(parse_dependencies_file)
    set(options IS_TEST)
    set(oneValueArgs DEPENDENCIES_FILE LIBRARIES_PARSED)
    cmake_parse_arguments(PARSED_ARGS "${options}" "${oneValueArgs}" "" ${ARGN})

    file(READ ${PARSED_ARGS_DEPENDENCIES_FILE} dependency_file_contents)
    string(REPLACE "\n" ";" dependencies_list ${dependency_file_contents})

    foreach (dependency_item ${dependencies_list})
        display_message("Parsing: ${dependency_item}")
        string(REPLACE "," ";" dependency ${dependency_item})

        list(GET dependency 1 dependency_name)
        list(GET dependency 2 dependency_url)
        list(GET dependency 3 dependency_tag)
        list(GET dependency 4 dependency_is_test)
        list(GET dependency 5 libraries_to_include)
        if ((${PARSED_ARGS_IS_TEST} STREQUAL "TRUE") OR (${dependency_is_test} STREQUAL "false"))
            display_message("Including dependency ${dependency_name} in build")
            downloadRepository(${dependency_name} ${dependency_url} ${dependency_tag})
            string(REPLACE " " ";" libraries ${libraries_to_include})
            foreach (library ${libraries})
                list(APPEND PARSED_ARGS_LIBRARIES_PARSED ${library})
            endforeach ()
        else ()
            display_warning("Excluding ${dependency_name} dependency. Reason: should_include_test_dependencies: ${should_include_test_dependencies}, dependency_is_test: ${dependency_is_test}")
        endif ()

    endforeach ()
    set(LIBRARIES_PARSED ${PARSED_ARGS_LIBRARIES_PARSED} PARENT_SCOPE)
endfunction()

#[[
Clone's provided dependency/repository.

name       - name of the GIT repository/dependency.
url        - GIT URL where the repository could be found.
tag        - GIT tag to clone.
]]
function(downloadRepository name url tag)
    display_message("Downloading Repository. name: ${name}, url: ${url}, tag: ${tag}")

    FetchContent_Declare(${name}
            GIT_REPOSITORY ${url}
            GIT_TAG ${tag})

    FetchContent_MakeAvailable(${name})

    display_message("Downloaded ${name}")
    #    display_message("${name} source directory ${${name}_SOURCE_DIR}")
    #    display_message("${name} binary directory ${${name}_BINARY_DIR}")
endfunction()

function(display_message status_message)
    message("----------------------------------------------------------------------")
    message(${status_message})
    message("----------------------------------------------------------------------\n")
endfunction()

function(display_warning warning_message)
    message("----------------------------------------------------------------------")
    message(WARNING ${warning_message})
    message("----------------------------------------------------------------------\n")
endfunction()