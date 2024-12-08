#!/bin/bash

# assemble and nasm x86 link input

mkdir -p output

#assemble
nasm -f elf64 ./src/main.s -o ./output/main.o
nasm -f elf64 ./src/calculate.s -o ./output/calculate.o
nasm -f elf64 ./src/strings.s -o ./output/strings.o
nasm -f elf64 ./src/syscall.s -o ./output/syscall.o

#link
ld ./output/main.o ./output/strings.o ./output/calculate.o ./output/syscall.o -o ./output/x86Calc

# disables warnings with -no-pie and -z noexecstack
# /usr/bin/ld: warning: ./output/strings: missing .note.GNU-stack section implies executable stack
# /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
# /usr/bin/ld: ./output/strings: warning: relocation in read-only section `.text'
# /usr/bin/ld: warning: creating DT_TEXTREL in a PIE