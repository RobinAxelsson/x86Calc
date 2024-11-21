#!/bin/bash

# assemble and nasm x86 link input

mkdir -p output

#assemble
nasm -f elf64 ./src/main.s -o ./output/main.o
nasm -f elf64 ./src/strings.s -o ./output/strings.o

#link
ld ./output/main.o ./output/strings.o -o ./output/main

for arg in "$@"; do
    if [[ "$arg" == "-g" ]]; then
        gdb -q "./output/main" $@ # Run under gdb if -g is found
        exit 0
    fi
done

./output/main $@