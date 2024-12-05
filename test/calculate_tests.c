//byte_arr_tests.c
#include <stdio.h>
#include <string.h>
//main is at end of file for convinience

//externs are written in x86 assembly
extern long calculate_string(char* string);

int passed = 0;
int tests = 0;

//--------------Test helpers------------------

char* apply_result(int boolean_result)
{
    tests++;
    char* fail = "";

    if(!boolean_result){
        fail = "<------ FAILED";
    }
    else {
        passed++;
    }

    return fail;
}

//------------------------------------------

void calculate_string__1_plus_1__2()
{
    char* input = "1+1";
    long res = calculate_string(input);
    long exp = 2;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__1_plus_1__2 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void calculate_string__1_plus_2__3()
{
    char* input = "1+2";
    long res = calculate_string(input);
    long exp = 3;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__1_plus_1__2 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

//notes:
//null terminator is implicit in C
//char res[5] creates read and writeable memory
//char *res = "0" gives only readable memory
//strcmp: stops at first /0, 0 means equal

//------------------------------------------

int main() 
{
    calculate_string__1_plus_1__2();
    calculate_string__1_plus_2__3();

    printf("\n");

    printf("---------------------------------------\n");
    printf("\n%d/%d tests passed!\n", passed, tests);

    if(passed == tests)
        return 0;
    
    return 1;
}