#!/bin/bash

mkdir -p output
./scripts/build.sh

strings(){
    gcc ./test/strings_tests.c ./output/strings.o -no-pie -o ./output/strings_tests -z noexecstack
    [ "$1" == "-g" ] && gdb -q ./output/strings_tests || ./output/strings_tests
}

calculate(){
    gcc ./test/calculate_tests.c ./output/strings.o ./output/calculate.o -no-pie -o ./output/calculate_tests -z noexecstack
    [ "$1" == "-g" ] && gdb -q ./output/calculate_tests || ./output/calculate_tests
}

main(){
    ./test/main_tests.sh "$@"
}

syscall(){
    gcc ./test/syscall_tests.c ./output/syscall.o -no-pie -o ./output/syscall_tests -z noexecstack
    [ "$1" == "-g" ] && gdb -q ./output/syscall_tests || ./output/syscall_tests
}

# run all tests
if [ "$1" == "" ]; then
    fail="0"

    echo -------MAIN---------
    main
    [ "$?" != "0" ] && fail=1

    echo
    echo ------STRINGS-------
    strings 
    [ "$?" != "0" ] && fail=1

    echo
    echo ------CALCULATE-----
    calculate 
    [ "$?" != "0" ] && fail=1

    echo
    echo ------SYSCALL-----
    syscall 
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
    strings)
        strings $2
        ;;
    main)
        main "$@"
        ;;
    calculate)
        calculate $2
        ;;
    syscall)
        syscall $2
        ;;
esac