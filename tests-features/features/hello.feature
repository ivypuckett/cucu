Feature: Hello World greeting

  Scenario: helloWorld returns the classic greeting
    When the hello world function is called
    Then the output is "Hello, World!"

  Scenario: greet with a name returns a personalised greeting
    When I greet "Alice"
    Then the output is "Hello, Alice!"

  Scenario: parse a blank string returns an empty json object
    Given a blank string
    When we call parse
    Then it returns an empty json object
