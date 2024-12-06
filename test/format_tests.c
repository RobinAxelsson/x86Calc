//strings_tests.c
#include <stdio.h>
#include <string.h>
//main is at end of file for convinience

//externs are written in x86 assembly
extern long convert_number_to_string(long number, char* dest);

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
//notes:
//null terminator is implicit in C
//char res[5] creates read and writeable memory
//char *res = "0" gives only readable memory
//strcmp: stops at first /0, 0 means equal

void convert_number_to_string__1_2__1null(){
    
    char res[5];
    convert_number_to_string(1, res);
    char* exp = "1";
    int str_equal = strcmp(res, exp) == 0;
    char *fail = apply_result(str_equal);
    printf("%d, convert_number_to_string__1_2__1null - expected: %s result: %s %s\n", tests, exp, res, fail);
}

void convert_number_to_string__1__not_equal_2(){
    char res[5];
    convert_number_to_string(1, res);
    char* not_exp = "2";
    int str_equal = strcmp(res, not_exp) != 0;
    char *fail = apply_result(str_equal);
    printf("%d, convert_number_to_string__1__not_equal_2 - expected: not %s result: %s %s\n", tests, not_exp, res, fail);
}

void convert_number_to_string__9__equal(){
    char res[5];
    convert_number_to_string(9, res);
    char* exp = "9";
    int str_equal = strcmp(res, exp) == 0;
    char *fail = apply_result(str_equal);
    printf("%d, convert_number_to_string__9__equal - expected: %s result: %s %s\n", tests, exp, res, fail);
}

void convert_number_to_string__69__equal(){
    char res[5];
    convert_number_to_string(69, res);
    char* exp = "69";

    int str_equal = strcmp(res, exp) == 0;
    char *fail = apply_result(str_equal);
    printf("%d, convert_number_to_string__9__equal - expected: %s result: %s %s\n", tests, exp, res, fail);
}

void convert_number_to_string__123456789__equal(){
    char res[10];
    convert_number_to_string(123456789, res);
    char* exp = "123456789";

    int str_equal = strcmp(res, exp) == 0;
    char *fail = apply_result(str_equal);
    printf("%d, convert_number_to_string__123456789__equal - expected: %s result: %s %s\n", tests, exp, res, fail);
}

void convert_number_to_string__0__equal(){
    char res[10];
    convert_number_to_string(0, res);
    char* exp = "0";

    int str_equal = strcmp(res, exp) == 0;
    char *fail = apply_result(str_equal);
    printf("%d, convert_number_to_string__0__equal - expected: %s result: %s %s\n", tests, exp, res, fail);
}

void convert_number_to_string__neg1__equal(){
    char res[10];
    convert_number_to_string(-1, res);
    char* exp = "-1";

    int str_equal = strcmp(res, exp) == 0;
    char *fail = apply_result(str_equal);
    printf("%d, convert_number_to_string__neg1__equal - expected: %s result: %s %s\n", tests, exp, res, fail);
}

void convert_number_to_string__check_null__null_exists(){
    char res[5] = "12345";

    convert_number_to_string(1, res);
    char* exp = "1";

    char *fail = apply_result(res[1] == exp[1]);
    printf("%d, convert_number_to_string__neg1__equal - expected: %s result: %s %s\n", tests, exp[1], res[1], fail);
}

void convert_number_to_string__1__len1(){
    char buffer[5];

    long res = convert_number_to_string(1, buffer);
    long exp = 1;

    char *fail = apply_result(res == exp);
    printf("%d, convert_number_to_string__1__len1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

//------------------------------------------

int main() 
{
    convert_number_to_string__1_2__1null();
    convert_number_to_string__1__not_equal_2();
    convert_number_to_string__9__equal();
    convert_number_to_string__69__equal();
    convert_number_to_string__123456789__equal();
    convert_number_to_string__0__equal();
    convert_number_to_string__check_null__null_exists();
    convert_number_to_string__neg1__equal();

    printf("\n");
    //length tests
    convert_number_to_string__1__len1();

    printf("---------------------------------------\n");
    printf("\n%d/%d tests passed!\n", passed, tests);

    if(passed == tests)
        return 0;
    
    return 1;
}