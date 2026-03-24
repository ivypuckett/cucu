## hello_cli - command-line interface for the hello library

import hello
import os

when isMainModule:
  let name =
    if paramCount() >= 1: commandLineParams()[0]
    else: "World"
  echo greet(name)
