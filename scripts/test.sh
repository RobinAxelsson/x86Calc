#!/bin/bash

nasm -f elf64 ./src/comp.s -o ./output/comp.o
gcc ./test/comp_tests.c ./output/comp.o -no-pie -o ./output/comp_tests.o -z noexecstack

# disables warnings with -no-pie and -z noexecstack
# /usr/bin/ld: warning: ./output/comp.o: missing .note.GNU-stack section implies executable stack
# /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
# /usr/bin/ld: ./output/comp.o: warning: relocation in read-only section `.text'
# /usr/bin/ld: warning: creating DT_TEXTREL in a PIE

./output/comp_tests