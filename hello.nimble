# Package
version     = "0.1.0"
author      = "cucu"
description = "Hello world library targeting C, JS, and CLI"
license     = "MIT"

# Dependencies
requires "nim >= 1.6.0"

# Tasks
task build_cli, "Build the CLI executable":
  exec "nim c --gc:arc -o:bin/hello src/hello_cli.nim"

task build_c_lib, "Build the shared C library (libhello.so)":
  exec "nim c --app:lib --noMain --gc:arc -o:bin/libhello.so src/hello_c.nim"

task build_c_static, "Build the static C library (libhello.a)":
  exec "nim c --app:staticlib --noMain --gc:arc -o:bin/libhello.a src/hello_c.nim"

task build_js, "Build the JavaScript output":
  exec "nim js -o:bin/hello.js src/hello_js.nim"

task build_all, "Build all targets (CLI, shared lib, static lib, JS)":
  exec "mkdir -p bin"
  nimbleTask "build_cli"
  nimbleTask "build_c_lib"
  nimbleTask "build_c_static"
  nimbleTask "build_js"
