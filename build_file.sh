#!/bin/bash

export ROOT=$PWD
BUILD_DIRECTORY="cmake/build/"
PROPERTIES_FILE="$ROOT/buildFlags.properties"
BUILD_FLAGS=""

print_message_to_console() {
  printf "\n===========================================================\n"
  printf "%s" "$1"
  printf "\n===========================================================\n"
}

parse_build_flags() {
  print_message_to_console "parsing properties from: ${PROPERTIES_FILE}"
  flag_option="-D"
  while read -r property; do
    BUILD_FLAGS="${BUILD_FLAGS} ${flag_option}${property}"
  done <"$PROPERTIES_FILE"

  print_message_to_console "BUILD_FLAGS: ${BUILD_FLAGS}"
}

run_cmake() {
  parse_build_flags
  cmake -G "Unix Makefiles" -B"${ROOT}"/"$1" "${BUILD_FLAGS}" \
    -Wdev \
    -H"$ROOT"
}

run_make() {
  print_message_to_console "Generating defined target..."
  cd "$1" && make -j
  buildPath="$(
    cd "$(dirname "$0")" >/dev/null 2>&1 || exit
    pwd -P
  )"
  printf "Done targets written to: %s" "${buildPath}"
}

main() {
  time_out_value=0
  if [ $# -eq 0 ]; then
    print_message_to_console "timeout not specified going with 0 timeout"
    time_out_value=0
  else
    time_out_value=$1
  fi
  if [ -d "${BUILD_DIRECTORY}" ]; then
    print_message_to_console "Found existing binary files. Do you want to clear existing binaries before continuing? (y/n):"
    read -n1 -t "$time_out_value" -r delete_existing_binaries
    if [ "$delete_existing_binaries" = "n" ] || [ "$delete_existing_binaries" = "N" ]; then
      print_message_to_console "Proceeding without clearing existing binary files"
    else
      print_message_to_console "Deleting existing binary files..."
      rm -rf "${BUILD_DIRECTORY}"
    fi
  fi

  run_cmake "$BUILD_DIRECTORY"

  print_message_to_console "Build completed. Would you like to make the targets? (y/n):"
  read -n1 -t "$time_out_value" -r should_make

  if [ "$should_make" = "n" ] || [ "$should_make" = "N" ]; then
    print_message_to_console "Skipping targets generation"
  else
    run_make "$BUILD_DIRECTORY"
  fi
}

if [ $# -eq 0 ]; then
  print_message_to_console "timeout not specified going with 0 timeout"
  main "0"
else
  main "$1"
fi
