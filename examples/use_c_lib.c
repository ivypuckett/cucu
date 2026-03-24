/* Example: call the Nim hello library from C
 *
 * Build (after running `make c-shared`):
 *   gcc -o use_c_lib examples/use_c_lib.c -Iinclude -Lbin -lhello -Wl,-rpath,bin
 */
#include <stdio.h>
#include "hello.h"

int main(void) {
    printf("%s\n", hello_world());
    printf("%s\n", hello_greet("Nim"));
    return 0;
}
