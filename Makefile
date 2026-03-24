BIN      := bin
NIM_FLAGS := --gc:arc

.PHONY: all cli c-shared c-static js clean

all: cli c-shared c-static js

$(BIN):
	mkdir -p $(BIN)

## CLI executable
cli: $(BIN)
	nim c $(NIM_FLAGS) -o:$(BIN)/hello src/hello_cli.nim

## Shared library (.so / .dylib)
c-shared: $(BIN)
	nim c --app:lib --noMain $(NIM_FLAGS) -o:$(BIN)/libhello.so src/hello_c.nim

## Static library (.a)
c-static: $(BIN)
	nim c --app:staticlib --noMain $(NIM_FLAGS) -o:$(BIN)/libhello.a src/hello_c.nim

## JavaScript
js: $(BIN)
	nim js -o:$(BIN)/hello.js src/hello_js.nim

clean:
	rm -rf $(BIN) nimcache
