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

#link or link with libc
[ "$2" == "-libc" ] || [ "$3" == "-libc" ] && ld $objfile -o $binfile -lc --dynamic-linker /lib64/ld-linux-x86-64.so.2 || ld $objfile -o $binfile

#run or debug
[ "$2" == "-g" ] || [ "$3" == "-g" ] && gdb -q --args "$binfile" "$@" || $binfile "$@"