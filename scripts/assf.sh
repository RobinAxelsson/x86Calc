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

#link
ld $objfile -o $binfile

#debug
[ "$2" == "-g" ] && gdb -q "$binfile" || $binfile