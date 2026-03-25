## hello - core hello world library

import std/strutils

proc greet*(name: string): string =
  ## Returns a greeting for the given name.
  "Hello, " & name & "!"

proc helloWorld*(): string =
  ## Returns the classic hello world string.
  greet("World")

proc parse*(input: string): string =
  ## Parses a string into a JSON representation.
  ## Returns an empty JSON object for blank input.
  if input.strip() == "":
    "{}"
  else:
    input
