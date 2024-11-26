#!/bin/bash

remove_file(){
    if [ -f "$1" ]; then
        rm "$1"
    fi
}

mkdir -p output

remove_file ./output/comp.o
remove_file ./output/comp_tests

nasm -f elf64 ./src/comp.s -o ./output/comp.o
gcc ./test/comp_tests.c ./output/comp.o -no-pie -o ./output/comp_tests -z noexecstack

# disables warnings with -no-pie and -z noexecstack
# /usr/bin/ld: warning: ./output/comp.o: missing .note.GNU-stack section implies executable stack
# /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
# /usr/bin/ld: ./output/comp.o: warning: relocation in read-only section `.text'
# /usr/bin/ld: warning: creating DT_TEXTREL in a PIE

./output/comp_tests
