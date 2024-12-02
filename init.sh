#!/bin/bash

# run with source ./init.sh

alias run="./scripts/build.sh && ./output/x86Calc"
alias run-no-build="./output/x86Calc"
alias debug="./scripts/build.sh && gdb -q --args "./output/main" "$@""
alias assf="./scripts/assf.sh"
alias dassf="./scripts/dassf.sh"
alias test="./scripts/test.sh"