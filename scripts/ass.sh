#!/bin/bash

# assemble and nasm x86 link input

# fileName="${1%%.*}" # remove .s extension

nasm -f elf64 "./src/fibo.s" -o "./output/fibo.o"

ld "./output/fibo.o" -o "./output/fibo"

[ "$2" == "-g" ] && gdb -q "./output/fibo" || "./output/fibo"