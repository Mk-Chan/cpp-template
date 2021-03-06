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
include_directories(src/main)
###

###
# Global Flags
###
add_compile_options(-Wall -Wextra -Wpedantic)
###

###
# Flags
###
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS_DEBUG "-DDEBUG -g -fno-omit-frame-pointer")
set(CMAKE_CXX_FLAGS_RELEASE "-DNDEBUG -O3")

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
    src/main/app/main.cpp
)
target_link_libraries(app PRIVATE spdlog::spdlog)

# app_test
add_executable(
    app_test
    src/test/test.cpp
    src/test/app/example.cpp
)
target_link_libraries(app_test PRIVATE Catch2::Catch2)
###
