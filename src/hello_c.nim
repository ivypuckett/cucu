## hello_c - C-exportable entry points for the hello library
##
## Compile with:
##   nim c --app:lib --noMain --gc:arc -o:libhello.so src/hello_c.nim
## or for a static library:
##   nim c --app:staticlib --noMain --gc:arc -o:libhello.a src/hello_c.nim

import hello

proc hello_greet*(name: cstring): cstring {.exportc, dynlib.} =
  ## C-callable wrapper for greet(). Caller must not free the returned pointer.
  greet($name).cstring

proc hello_world*(): cstring {.exportc, dynlib.} =
  ## C-callable wrapper for helloWorld().
  hello.helloWorld().cstring

proc hello_parse*(input: cstring): cstring {.exportc, dynlib.} =
  ## C-callable wrapper for parse().
  hello.parse($input).cstring
