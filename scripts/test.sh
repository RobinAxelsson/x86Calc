#!/bin/bash

mkdir -p output


format(){
    nasm -f elf64 ./src/format.s -o ./output/format.o
    gcc ./test/format_tests.c ./output/format.o -no-pie -o ./output/format_tests -z noexecstack

    [ "$1" == "-g" ] && gdb -q ./output/format_tests || ./output/format_tests
}

equals(){
    nasm -f elf64 ./src/equals.s -o ./output/equals.o
    gcc ./test/equals_tests.c ./output/equals.o -no-pie -o ./output/equals_tests -z noexecstack
    
    [ "$1" == "-g" ] && gdb -q ./output/equals_tests || ./output/equals_tests
}

main(){
    ./test/main_tests.sh
}

# run all tests
if [ "$1" == "" ]; then
    fail="0"

    echo -------MAIN---------
    main
    [ "$?" != "0" ] && fail=1

    echo
    echo -------FORMAT-------
    format
    [ "$?" != "0" ] && fail=1

    echo
    echo -------EQUALS-------
    equals 
    [ "$?" != "0" ] && fail=1

    echo
    echo -------RESULT-------
    if [ "$fail" == "1" ]; then
        echo "FAILED"
        exit 1
    fi

    echo "PASSED"
    exit 0
fi

case "$1" in
    format)
        format $2
        ;;
    equals)
        equals $2
        ;;
    main)
        main
        ;;
esac