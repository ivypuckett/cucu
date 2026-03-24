Feature: Hello World JavaScript module

  Scenario: helloWorld returns the classic greeting
    When the hello world function is called
    Then the output is "Hello, World!"

  Scenario: greet with a name returns a personalised greeting
    When I greet "Alice"
    Then the output is "Hello, Alice!"
