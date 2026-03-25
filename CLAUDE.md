# CLAUDE.md

## Project Overview

**cucu** is a Hello World library written in Nim, targeting multiple output formats:
- A CLI executable (`bin/hello`)
- A shared C library (`bin/libhello.so`)
- A static C library (`bin/libhello.a`)
- A JavaScript module (`bin/hello.js`)

Source is in `src/`, C headers in `include/`, build outputs go to `bin/`.

## First-time setup

If `nim`, `task`, or the C++ test dependencies are missing, run:

```sh
sudo bash scripts/setup.sh
```

This installs: nim, the Task CLI (from GitHub releases — taskfile.dev may be
blocked in restricted environments), all C++ build deps (gtest, nlohmann_json,
asio, tclap, boost), and builds/installs cucumber-cpp from source.

## Build

The project uses [Task](https://taskfile.dev) (`task` CLI) as the task runner.

```sh
task          # build all targets (cli, c-shared, c-static, js)
task cli      # build bin/hello
task c-shared # build bin/libhello.so
task c-static # build bin/libhello.a
task js       # build bin/hello.js
task clean    # remove bin/ and nimcache/
```

## Tests

Feature files live in `tests-features/features/`. Three test suites each implement those features:

| Folder       | Runner            | Command               | Requires      |
|--------------|-------------------|-----------------------|---------------|
| `tests-cli`  | Ruby / Cucumber   | `bundle exec cucumber`| `bin/hello`   |
| `tests-js`   | Node.js / Cucumber| `npm test`            | `bin/hello.js`|
| `tests-cpp`  | C++ / Cucumber    | `bundle exec cucumber`| `bin/libhello.so` + cmake build |

### Run all tests

```sh
task test
```

This runs `test-cli`, `test-js`, and `test-cpp` in sequence (each installs its own dependencies first).

### Run a single suite

```sh
task test-cli
task test-js
task test-cpp
```

### Run without Task

```sh
# CLI suite
cd tests-cli && bundle install && bundle exec cucumber && cd ..

# JS suite
cd tests-js && npm install && npm test && cd ..

# C++ suite (also needs bin/libhello.so built first)
cd tests-cpp && cmake -B build -S . && cmake --build build && bundle install && bundle exec cucumber && cd ..
```

## Before Committing

**Always run all tests before committing:**

```sh
task test
```

All three test suites must pass. Do not commit if any tests fail.
