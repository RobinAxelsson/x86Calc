#!/bin/bash

mkdir -p output
./scripts/build.sh

strings(){
    gcc ./test/strings_tests.c ./output/strings.o -no-pie -o ./output/strings_tests -z noexecstack
    [ "$1" == "-g" ] && gdb -q ./output/strings_tests || ./output/strings_tests
}

format(){
    gcc ./test/format_tests.c ./output/strings.o ./output/format.o -no-pie -o ./output/format_tests -z noexecstack
    [ "$1" == "-g" ] && gdb -q ./output/format_tests || ./output/format_tests
}


calculate(){
    gcc ./test/calculate_tests.c ./output/strings.o ./output/calculate.o -no-pie -o ./output/calculate_tests -z noexecstack
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
    strings 
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
    strings)
        strings $2
        ;;
    main)
        main "$@"
        ;;
    calculate)
        calculate $2
        ;;
esac