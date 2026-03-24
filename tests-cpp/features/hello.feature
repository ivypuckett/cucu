Feature: Hello World C bindings

  Scenario: hello_world returns the classic greeting
    When the hello world function is called
    Then the output is "Hello, World!"

  Scenario: hello_greet with a name returns a personalised greeting
    When I greet "Alice"
    Then the output is "Hello, Alice!"
