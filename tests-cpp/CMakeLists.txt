cmake_minimum_required(VERSION 3.15)
project(HelloCucumberCpp CXX)

set(CMAKE_CXX_STANDARD 14)

find_package(nlohmann_json REQUIRED)
find_package(CucumberCpp REQUIRED)
find_package(GTest REQUIRED)

add_executable(hello-steps src/hello_steps.cpp)

target_include_directories(hello-steps PRIVATE
  ${PROJECT_SOURCE_DIR}/../include
)

target_link_libraries(hello-steps PRIVATE
  CucumberCpp::cucumber-cpp
  GTest::gtest
  ${PROJECT_SOURCE_DIR}/../bin/libhello.so
)
