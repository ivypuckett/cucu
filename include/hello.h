#ifndef HELLO_H
#define HELLO_H

#ifdef __cplusplus
extern "C" {
#endif

/** Returns a greeting for the given name. The returned pointer is valid until
 *  the next call to hello_greet() or hello_world() from the same thread. */
const char* hello_greet(const char* name);

/** Returns the classic "Hello, World!" string. */
const char* hello_world(void);

/** Parses a string into a JSON representation. Returns "{}" for blank input. */
const char* hello_parse(const char* input);

#ifdef __cplusplus
}
#endif

#endif /* HELLO_H */
