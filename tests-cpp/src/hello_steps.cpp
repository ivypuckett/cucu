#include <gtest/gtest.h>
#include <cucumber-cpp/autodetect.hpp>

extern "C" {
#include "hello.h"
}

#include <string>

using namespace cucumber;

struct CucuContext {
    std::string result;
    std::string input;
};

WHEN("^I greet \"([^\"]*)\"$") {
    REGEX_PARAM(std::string, name);
    ScenarioScope<CucuContext> ctx;
    ctx->result = hello_greet(name.c_str());
}

THEN("^the output is \"([^\"]*)\"$") {
    REGEX_PARAM(std::string, expected);
    ScenarioScope<CucuContext> ctx;
    ASSERT_EQ(ctx->result, expected);
}

GIVEN("^a blank string$") {
    ScenarioScope<CucuContext> ctx;
    ctx->input = "";
}

WHEN("^we call parse$") {
    ScenarioScope<CucuContext> ctx;
    ctx->result = hello_parse(ctx->input.c_str());
}

THEN("^it returns an empty json object$") {
    ScenarioScope<CucuContext> ctx;
    ASSERT_EQ(ctx->result, "{}");
}
