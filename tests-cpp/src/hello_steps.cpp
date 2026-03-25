#include <cucumber-cpp/autodetect.hpp>
#include <gtest/gtest.h>

extern "C" {
#include "hello.h"
}

#include <string>

struct HelloContext {
    std::string result;
};

WHEN("^the hello world function is called$") {
    ScenarioScope<HelloContext> ctx;
    ctx->result = hello_world();
}

WHEN("^I greet \"([^\"]*)\"$") {
    REGEX_PARAM(std::string, name);
    ScenarioScope<HelloContext> ctx;
    ctx->result = hello_greet(name.c_str());
}

THEN("^the output is \"([^\"]*)\"$") {
    REGEX_PARAM(std::string, expected);
    ScenarioScope<HelloContext> ctx;
    ASSERT_EQ(ctx->result, expected);
}
