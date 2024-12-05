#!/bin/bash

mkdir -p output


format(){
    nasm -f elf64 ./src/format.s -o ./output/format.o
    gcc ./test/format_tests.c ./output/format.o -no-pie -o ./output/format_tests -z noexecstack

    [ "$1" == "-g" ] && gdb -q ./output/format_tests || ./output/format_tests
}

byte_arr(){
    nasm -f elf64 ./src/byte_arr.s -o ./output/byte_arr
    gcc ./test/byte_arr_tests.c ./output/byte_arr -no-pie -o ./output/byte_arr_tests -z noexecstack
    
    [ "$1" == "-g" ] && gdb -q ./output/byte_arr_tests || ./output/byte_arr_tests
}

calculate(){
    nasm -f elf64 ./src/calculate.s -o ./output/calculate
    gcc ./test/calculate_tests.c ./output/calculate -no-pie -o ./output/calculate_tests -z noexecstack
    
    [ "$1" == "-g" ] && gdb -q ./output/calculate_tests || ./output/calculate_tests
}

main(){
    ./test/main_tests.sh "$@"
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
    byte_arr 
    [ "$?" != "0" ] && fail=1

    echo
    echo ------CALCULATE-----
    calculate 
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
    byte_arr)
        byte_arr $2
        ;;
    main)
        main "$@"
        ;;
    calculate)
        calculate $2
        ;;
esac