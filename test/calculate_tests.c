//strings_tests.c
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

void calculate_string__12_plus_2__14()
{
    char* input = "12+2";
    long res = calculate_string(input);
    long exp = 14;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__12_plus_2__14 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void calculate_string__13_plus_21__34()
{
    char* input = "13+21";
    long res = calculate_string(input);
    long exp = 13+21;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__13_plus_21__34 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void calculate_string__10_plus_1__11()
{
    char* input = "10+1";
    long res = calculate_string(input);
    long exp = 11;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__10_plus_1__11 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void calculate_string__200_plus_1__201()
{
    char* input = "200+1";
    long res = calculate_string(input);
    long exp = 201;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__200_plus_1__201 - expected: %d result: %d %s\n", tests, exp, res, fail);
}


void calculate_string__0_plus_1000__1000()
{
    char* input = "0+1000";
    long res = calculate_string(input);
    long exp = 1000;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__0_plus_1000__1000 - expected: %d result: %d %s\n", tests, exp, res, fail);
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
    calculate_string__12_plus_2__14();
    calculate_string__13_plus_21__34();
    calculate_string__10_plus_1__11();
    calculate_string__200_plus_1__201();
    calculate_string__0_plus_1000__1000();

    printf("\n");

    printf("---------------------------------------\n");
    printf("\n%d/%d tests passed!\n", passed, tests);

    if(passed == tests)
        return 0;
    
    return 1;
}