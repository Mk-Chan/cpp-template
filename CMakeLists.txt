cmake_minimum_required(VERSION 3.12)

project(app)

###
# Find packages
###
find_package(spdlog CONFIG REQUIRED)
find_package(Catch2 CONFIG REQUIRED)
###

###
# Base directory relative includes for everyone
###
include_directories(.)
###

###
# Global Flags
###
if (MSVC)
    add_compile_options(/W3)
else ()
    add_compile_options(-Wall -Wextra)
endif ()
###

###
# Flags
###
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS "-Wpedantic -O3")
set(CMAKE_CXX_FLAGS_DEBUG "-g -fno-omit-frame-pointer")
set(CMAKE_CXX_FLAGS_RELEASE "-DNDEBUG")

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif ()
###

###
# Tests
###
enable_testing()
add_test(app_test_build "${CMAKE_COMMAND}" --build "${CMAKE_BINARY_DIR}" --target app_test)
add_test(app_test_run app_test)
set_tests_properties(app_test_run PROPERTIES DEPENDS app_test_build)
###

###
# Targets
###
# app
add_executable(
    app
    app/main.cpp
    )
target_link_libraries(app PRIVATE spdlog::spdlog)
target_include_directories(app PRIVATE include)

# app_test
add_executable(
    app_test
    test/test.cpp
    test/app/example.cpp
    )
target_link_libraries(app_test PRIVATE Catch2::Catch2)
###