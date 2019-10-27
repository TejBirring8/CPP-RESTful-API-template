cmake_minimum_required(VERSION 3.15)
project(server)

set(CMAKE_CXX_STANDARD 17)


add_executable(server main.cpp)

# mandatory definitions
add_definitions( -DASIO_STANDALONE )
add_definitions( -DFMT_HEADER_ONLY )

# include dirs
target_include_directories(
        server
        PRIVATE
        restinio/dev
        asio/asio-1.12.2/include
        restinio/dev/restinio
        http-parser
        fmt/include
)

# try find lib_http_parser.a library
find_library (
        LIB_HTTP_PARSER
        NAMES libhttp_parser.a # what to look for
        HINTS "http-parser/build" # where to look
        NO_DEFAULT_PATH # do not search system default paths
)

# check if we found the library
message(STATUS "LIB_HTTP_PARSER: [${LIB_HTTP_PARSER}]")

# link lib_http_parser.a with server
target_link_libraries( server ${LIB_HTTP_PARSER} )



