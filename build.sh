#!/bin/bash

# set cd to directory of this script
MY_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd "$MY_DIR" || exit

# build http-parser
if [ -d "http-parser/build" ]; then
  rm -rf "http-parser/build"
  echo "libhttp_parser.a already exists, removing..."
fi

cd "http-parser" && mkdir "build" && cd "build" || exit
cmake .. && make || exit

# check to see if libhttp_parser.a built successfully
if [ ! -f "libhttp_parser.a" ]; then
  echo "failed to build libhttp_parser.a!" && exit
fi

# now build the server - delete the build dir if already exists
cd "$MY_DIR" || exit

if [ -d "build" ]; then
  rm -rf "build"
  echo "server build dir already exists, removing..."
fi

# finally build the server
mkdir "build" && cd "build" && cmake .. && make || exit



