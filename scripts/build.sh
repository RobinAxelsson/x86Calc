#!/bin/bash

# assemble and nasm x86 link input

mkdir -p output

#assemble
mkdir -p output
nasm -f elf64 ./src/main.s -o ./output/main.o
nasm -f elf64 ./src/args.s -o ./output/args.o
nasm -f elf64 ./src/byte_arr.s -o ./output/byte_arr
nasm -f elf64 ./src/format.s -o ./output/format.o
nasm -f elf64 ./src/syscall.s -o ./output/syscall.o

#link
ld ./output/main.o -o ./output/calc

# ld ./output/main.o ./output/strings.o ./output/args.o -o ./output/main

# disables warnings with -no-pie and -z noexecstack
# /usr/bin/ld: warning: ./output/byte_arr: missing .note.GNU-stack section implies executable stack
# /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
# /usr/bin/ld: ./output/byte_arr: warning: relocation in read-only section `.text'
# /usr/bin/ld: warning: creating DT_TEXTREL in a PIE