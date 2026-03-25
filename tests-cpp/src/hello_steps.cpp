#include <gtest/gtest.h>
#include <cucumber-cpp/autodetect.hpp>

extern "C" {
#include "hello.h"
}

#include <string>

using namespace cucumber;

struct HelloContext {
    std::string result;
    std::string input;
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

GIVEN("^a blank string$") {
    ScenarioScope<HelloContext> ctx;
    ctx->input = "";
}

WHEN("^we call parse$") {
    ScenarioScope<HelloContext> ctx;
    ctx->result = hello_parse(ctx->input.c_str());
}

THEN("^it returns an empty json object$") {
    ScenarioScope<HelloContext> ctx;
    ASSERT_EQ(ctx->result, "{}");
}
