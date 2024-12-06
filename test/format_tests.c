//byte_arr_tests.c
#include <stdio.h>
#include <string.h>
//main is at end of file for convinience

//externs are written in x86 assembly
extern long char_parse_numb_rdi_number_rsi_ptr_raxlength(long number, char* dest);

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

void char_parse_numb_rdi_number_rsi_ptr_raxlength__1_2__1null(){
    
    char res[5];
    char_parse_numb_rdi_number_rsi_ptr_raxlength(1, res);
    char* exp = "1";
    int str_equal = strcmp(res, exp) == 0;
    char *fail = apply_result(str_equal);
    printf("%d, char_parse_numb_rdi_number_rsi_ptr_raxlength__1_2__1null - expected: %s result: %s %s\n", tests, exp, res, fail);
}

void char_parse_numb_rdi_number_rsi_ptr_raxlength__1__not_equal_2(){
    char res[5];
    char_parse_numb_rdi_number_rsi_ptr_raxlength(1, res);
    char* not_exp = "2";
    int str_equal = strcmp(res, not_exp) != 0;
    char *fail = apply_result(str_equal);
    printf("%d, char_parse_numb_rdi_number_rsi_ptr_raxlength__1__not_equal_2 - expected: not %s result: %s %s\n", tests, not_exp, res, fail);
}

void char_parse_numb_rdi_number_rsi_ptr_raxlength__9__equal(){
    char res[5];
    char_parse_numb_rdi_number_rsi_ptr_raxlength(9, res);
    char* exp = "9";
    int str_equal = strcmp(res, exp) == 0;
    char *fail = apply_result(str_equal);
    printf("%d, char_parse_numb_rdi_number_rsi_ptr_raxlength__9__equal - expected: %s result: %s %s\n", tests, exp, res, fail);
}

void char_parse_numb_rdi_number_rsi_ptr_raxlength__69__equal(){
    char res[5];
    char_parse_numb_rdi_number_rsi_ptr_raxlength(69, res);
    char* exp = "69";

    int str_equal = strcmp(res, exp) == 0;
    char *fail = apply_result(str_equal);
    printf("%d, char_parse_numb_rdi_number_rsi_ptr_raxlength__9__equal - expected: %s result: %s %s\n", tests, exp, res, fail);
}

void char_parse_numb_rdi_number_rsi_ptr_raxlength__123456789__equal(){
    char res[10];
    char_parse_numb_rdi_number_rsi_ptr_raxlength(123456789, res);
    char* exp = "123456789";

    int str_equal = strcmp(res, exp) == 0;
    char *fail = apply_result(str_equal);
    printf("%d, char_parse_numb_rdi_number_rsi_ptr_raxlength__123456789__equal - expected: %s result: %s %s\n", tests, exp, res, fail);
}

void char_parse_numb_rdi_number_rsi_ptr_raxlength__0__equal(){
    char res[10];
    char_parse_numb_rdi_number_rsi_ptr_raxlength(0, res);
    char* exp = "0";

    int str_equal = strcmp(res, exp) == 0;
    char *fail = apply_result(str_equal);
    printf("%d, char_parse_numb_rdi_number_rsi_ptr_raxlength__0__equal - expected: %s result: %s %s\n", tests, exp, res, fail);
}

void char_parse_numb_rdi_number_rsi_ptr_raxlength__neg1__equal(){
    char res[10];
    char_parse_numb_rdi_number_rsi_ptr_raxlength(-1, res);
    char* exp = "-1";

    int str_equal = strcmp(res, exp) == 0;
    char *fail = apply_result(str_equal);
    printf("%d, char_parse_numb_rdi_number_rsi_ptr_raxlength__neg1__equal - expected: %s result: %s %s\n", tests, exp, res, fail);
}

void char_parse_numb_rdi_number_rsi_ptr_raxlength__check_null__null_exists(){
    char res[5] = "12345";

    char_parse_numb_rdi_number_rsi_ptr_raxlength(1, res);
    char* exp = "1";

    char *fail = apply_result(res[1] == exp[1]);
    printf("%d, char_parse_numb_rdi_number_rsi_ptr_raxlength__neg1__equal - expected: %s result: %s %s\n", tests, exp[1], res[1], fail);
}

void char_parse_numb_rdi_number_rsi_ptr_raxlength__1__len2(){
    char buffer[5];

    long res = char_parse_numb_rdi_number_rsi_ptr_raxlength(1, buffer);
    long exp = 2;

    char *fail = apply_result(res == exp);
    printf("%d, char_parse_numb_rdi_number_rsi_ptr_raxlength__1__len2 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

//------------------------------------------

int main() 
{
    char_parse_numb_rdi_number_rsi_ptr_raxlength__1_2__1null();
    char_parse_numb_rdi_number_rsi_ptr_raxlength__1__not_equal_2();
    char_parse_numb_rdi_number_rsi_ptr_raxlength__9__equal();
    char_parse_numb_rdi_number_rsi_ptr_raxlength__69__equal();
    char_parse_numb_rdi_number_rsi_ptr_raxlength__123456789__equal();
    char_parse_numb_rdi_number_rsi_ptr_raxlength__0__equal();
    char_parse_numb_rdi_number_rsi_ptr_raxlength__check_null__null_exists();
    char_parse_numb_rdi_number_rsi_ptr_raxlength__neg1__equal();

    printf("\n");
    //length tests
    char_parse_numb_rdi_number_rsi_ptr_raxlength__1__len2();

    printf("---------------------------------------\n");
    printf("\n%d/%d tests passed!\n", passed, tests);

    if(passed == tests)
        return 0;
    
    return 1;
}