cmake_minimum_required(VERSION 3.15)
project(HelloCucumberCpp CXX)

set(CMAKE_CXX_STANDARD 14)

find_package(GTest REQUIRED)
find_package(nlohmann_json REQUIRED)
find_package(CucumberCpp REQUIRED)

add_executable(hello-steps src/hello_steps.cpp)

target_include_directories(hello-steps PRIVATE
  ${PROJECT_SOURCE_DIR}/../include
)

target_link_libraries(hello-steps PRIVATE
  CucumberCpp::cucumber-cpp
  GTest::gmock
  GTest::gtest
  ${PROJECT_SOURCE_DIR}/../bin/libhello.so
)
