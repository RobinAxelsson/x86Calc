// equals_tests.c
#include <stdio.h>
//main is at end of file for convinience

//externs are written in x86 assembly
extern long decimal_parse(char* string);

int passed = 0;
int tests = 0;

char* apply_result(int boolean_result)
{
    tests++;
    char* fail = "";

    if(!boolean_result){
        fail = " - FAILED";
    }
    else {
        passed++;
    }

    return fail;
}

void decimal_parse_1_1()
{
    char* input = "1\0";
    char res = decimal_parse(input);
    char exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, decimal_parse_1_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void decimal_parse_11_11()
{
    char* input = "21\0";
    long res = decimal_parse(input);
    long exp = 21;
    char *fail = apply_result(exp == res);

    printf("%d, decimal_parse_1_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}


int main() 
{
    decimal_parse_1_1();
    decimal_parse_11_11();

    //Summary
    printf("---------------------------------------\n");
    printf("\n%d/%d tests passed!\n", passed, tests);

    if(passed == tests)
        return 0;
    
    return 1;
}