// hello.c
#include <stdio.h>

extern void comp1(void);

int main() {
    printf("Hello, World!\n");
    comp1();
    return 0;
}