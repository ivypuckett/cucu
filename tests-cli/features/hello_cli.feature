Feature: Hello CLI

  Scenario: Running with no arguments prints "Hello, World!"
    When I run `hello`
    Then the output should contain "Hello, World!"

  Scenario: Running with a name argument prints a personalised greeting
    When I run `hello Alice`
    Then the output should contain "Hello, Alice!"
