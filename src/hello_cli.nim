## hello_cli - command-line interface for the hello library

import hello
import os

when isMainModule:
  if paramCount() >= 1 and commandLineParams()[0] == "--parse":
    let input = if paramCount() >= 2: commandLineParams()[1] else: ""
    echo parse(input)
  else:
    let name = if paramCount() >= 1: commandLineParams()[0] else: "World"
    echo greet(name)
