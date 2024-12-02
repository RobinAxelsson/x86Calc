#!/bin/bash

# prefer to send it to std out (echo)

#-------BUILD--------

mkdir -p output
./scripts/build.sh

#-----TEST-SETUP-----

tests=0
passed=0

run_exit_test(){
    eval "$1" # test-expression
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

#-------SUMMARY------
echo "--------------------------"
echo "$passed"/"$tests" passed

if [ $passed -ne $tests ]; then
    exit 1
fi