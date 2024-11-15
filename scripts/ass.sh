#!/bin/bash

# assemble and nasm x86 link input
# alias ass="./scripts/ass.sh"


# fileName=$1
filename="fibo"

asmfile="./src/"$filename".s"
objfile="./output/"$filename".o"
binfile="./output/"$filename

mkdir -p output

#assemble
nasm -f elf64 $asmfile -o $objfile

#link
ld $objfile -o $binfile

#debug
[ "$1" == "-g" ] && gdb -q "$binfile" || $binfile