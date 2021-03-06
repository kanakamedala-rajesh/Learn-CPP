cmake_minimum_required(VERSION 3.17)
set(CMAKE_CXX_STANDARD 14)
include(FetchContent)

#[[
Parses provided dependencies file.

dependencies_file_path           - dependencies.csv file path.
should_include_test_dependencies - indicates if test dependencies should be included.
includedLibraries                - output variable which includes all libraries to be linked from dependency.
]]
function(parse_dependencies_file dependencies_file_path should_include_test_dependencies includedLibraries)
    file(READ ${dependencies_file_path} dependency_file_contents)
    string(REPLACE "\n" ";" dependencies_list ${dependency_file_contents})

    foreach (dependency_item ${dependencies_list})
        display_message("Parsing: ${dependency_item}")
        string(REPLACE "," ";" dependency ${dependency_item})

        list(GET dependency 1 dependency_name)
        list(GET dependency 2 dependency_url)
        list(GET dependency 3 dependency_tag)
        list(GET dependency 4 dependency_is_test)
        list(GET dependency 5 libraries_to_include)

        if ((${should_include_test_dependencies} STREQUAL "true") OR (${dependency_is_test} STREQUAL "false"))
            display_message("Including dependency ${dependency_name} in build")
            downloadRepository(${dependency_name} ${dependency_url} ${dependency_tag})
            string(REPLACE " " ";" libraries ${libraries_to_include})
            foreach (library ${libraries})
                list(APPEND includedLibraries ${library})
            endforeach ()
        else ()
            display_warning("Excluding ${dependency_name} dependency. Reason: should_include_test_dependencies: ${should_include_test_dependencies}, dependency_is_test: ${dependency_is_test}")
        endif ()

    endforeach ()
    SET(${includedLibraries} PARENT_SCOPE)
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