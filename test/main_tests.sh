#!/bin/bash

# prefer to send it to std out (echo)

#-------BUILD--------

mkdir -p output
./scripts/build.sh

#-----TEST-SETUP-----

tests=0
passed=0
gdb=0
debug_test=0
i_test=1

if [[ "$2" == "-g" ]]; then
    gdb=1
    debug_test=$3
fi

run_exit_test(){
    if [ "$gdb" == 1  ]; then
        eval gdb -q --args "$1"
    else
        eval "$1"
    fi
    
    res="$?"
    exp="$2"

    ((tests++))
    if [ $exp -eq $res ]; then
        ((passed++))   # (()) is for aritmetics, no $ needed
    else 
        fail="<------ FAILED"
    fi

    echo "$1 res=$res exp=$exp $fail"
}

#-------TESTS--------

# wrong input expect fail
# $? is return value for any function or command (exit status)

run_exit_test "./output/x86Calc" 1
run_exit_test "./output/x86Calc 1+1" 0
run_exit_test "./output/x86Calc 11" 1

#-------SUMMARY------
echo "--------------------------"
echo "$passed"/"$tests" passed

if [ $passed -ne $tests ]; then
    exit 1
fi