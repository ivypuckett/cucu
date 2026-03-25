## hello_js - JavaScript entry point for the hello library
##
## Compile with:
##   nim js -o:hello.js src/hello_js.nim

import hello

when defined(js):
  import std/jsffi

  proc jsGreet(name: cstring): cstring {.exportc.} =
    greet($name).cstring

  proc jsHelloWorld(): cstring {.exportc.} =
    helloWorld().cstring

  proc jsParse(input: cstring): cstring {.exportc.} =
    parse($input).cstring

  # Make functions available on the global object when loaded as a script.
  {.emit: """
    if (typeof module !== 'undefined' && module.exports) {
      module.exports = { greet: jsGreet, helloWorld: jsHelloWorld, parse: jsParse };
    } else if (typeof window !== 'undefined') {
      window.hello = { greet: jsGreet, helloWorld: jsHelloWorld, parse: jsParse };
    }
  """.}

  when isMainModule:
    echo jsHelloWorld()
