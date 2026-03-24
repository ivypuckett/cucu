## hello - core hello world library

proc greet*(name: string): string =
  ## Returns a greeting for the given name.
  "Hello, " & name & "!"

proc helloWorld*(): string =
  ## Returns the classic hello world string.
  greet("World")
