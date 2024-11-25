#!/bin/bash

# alias dass="./scripts/dass.sh"

filepath=$1
filename=$(basename $1)

binfile=$filepath
outfile=./output/$filename

mkdir -p output

if [[ $2 == '-v'|| $2 == '--verbose' ]]; then
    objdump -x -D -a --full-contents --source --syms -M intel -C -f -g $binfile > $outfile"-dump-verbose.s"
    #objdump -D -M intel $binfile > $outfile"-dump-verbose.s"

else
    #objdump -M intel -d --full-contents -g $binfile > $outfile"-dump.s"
    objdump -M intel -d $binfile > $outfile"-dump.s"
fi

# --no-show-raw-insn no hex
# -x all headers
# -D --disassemble-al
# -s --full-contents
# -t --syms
# -M format
# -d dissasemble executables
# -a: Shows all headers, including file and section headers (this is more extensive than -x).
# -C: Demangles C++ symbol names (if applicable). This can help if the binary has C++ symbols that are mangled and you'd like to see them in a human-readable format.
# -f: Displays the file header, which gives you information about the binary format, entry point, architecture, and more.
# -p: program header