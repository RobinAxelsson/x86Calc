#!/bin/bash

# assemble and nasm x86 link input
# alias ass="./scripts/ass.sh"

#filepath=./src/print-123.s
#filepath=./src/div10.s
#filepath=./src/fibonacci.s
#filepath=./src/hello-world.s
filepath=./src/print-args.s
./scripts/assf.sh $filepath "$@"