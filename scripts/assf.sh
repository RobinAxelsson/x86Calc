#!/bin/bash

# assemble and nasm x86 link input

asmfile=$1
filename=$(basename "$asmfile")
filename=${filename%.*}

objfile="./output/"$filename".o"
binfile="./output/"$filename

mkdir -p output

#assemble
nasm -f elf64 $asmfile -o $objfile

#link - also with libc library
ld $objfile -o $binfile -lc --dynamic-linker /lib64/ld-linux-x86-64.so.2

#debug
[ "$2" == "-g" ] && gdb -q "$binfile" || $binfile