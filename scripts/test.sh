#!/bin/bash

remove_file(){
    if [ -f "$1" ]; then
        rm "$1"
    fi
}

mkdir -p output

remove_file ./output/equals.o
remove_file ./output/equals_tests

nasm -f elf64 ./src/equals.s -o ./output/equals.o
gcc ./test/equals_tests.c ./output/equals.o -no-pie -o ./output/equals_tests -z noexecstack

# disables warnings with -no-pie and -z noexecstack
# /usr/bin/ld: warning: ./output/equals.o: missing .note.GNU-stack section implies executable stack
# /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
# /usr/bin/ld: ./output/equals.o: warning: relocation in read-only section `.text'
# /usr/bin/ld: warning: creating DT_TEXTREL in a PIE

./output/equals_tests
