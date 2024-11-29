// equals_tests.c
#include <stdio.h>
#include <string.h>
//main is at end of file for convinience

//externs are written in x86 assembly
extern long decimal_parse(char* string);
extern long str_length(char* string);
extern long get_decimal_i(char* string, long index);
extern long mul10(long number, char power);
extern long extend_decimal_rdi_numb_rsi_len_rdx_i(long decimal, long length, long index);
extern void char_parse_numb_rdi_number_rsi_ptr(long number, char* dest);

int passed = 0;
int tests = 0;

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

void decimal_parse_1_1()
{
    char* input = "1\0";
    char res = decimal_parse(input);
    char exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, decimal_parse_1_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void decimal_parse_21_21()
{
    char* input = "21\0";
    long res = decimal_parse(input);
    long exp = 21;
    char *fail = apply_result(exp == res);

    printf("%d, decimal_parse_21_21 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void decimal_parse_99_99()
{
    char* input = "99\0";
    long res = decimal_parse(input);
    long exp = 99;
    char *fail = apply_result(exp == res);

    printf("%d, decimal_parse_99_99 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void decimal_parse_169_169()
{
    char* input = "169\0";
    long res = decimal_parse(input);
    long exp = 169;
    char *fail = apply_result(exp == res);

    printf("%d, decimal_parse_169_169 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_length_abc_3(){
    char* input = "abc\0";
    long res = str_length(input);
    long exp = 3;
    char *fail = apply_result(exp == res);

    printf("%d, str_length_abc_3 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void get_decimal_i_123and0_1(){
    char* input = "123";
    long res = get_decimal_i(input, 0);
    long exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, get_decimal_i_123and0_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void get_decimal_i_123and1_2(){
    char* input = "123";
    long res = get_decimal_i(input, 1);
    long exp = 2;
    char *fail = apply_result(exp == res);

    printf("%d, get_decimal_i_123and1_2 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void get_decimal_i_123and2_3(){
    char* input = "123";
    long res = get_decimal_i(input, 2);
    long exp = 3;
    char *fail = apply_result(exp == res);

    printf("%d, get_decimal_i_123and2_3 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_length_null_0(){
    char* input = "\0";
    long res = str_length(input);
    long exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, str_length_null_0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void mul10_5and2_500(){
    long number = 5;
    char power = 3;
    long res = mul10(number, power);
    long exp = 5000;
    char *fail = apply_result(exp == res);

    printf("%d, mul10_5and2_500 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void mul10_5and0_5(){
    long number = 5;
    char power = 0;
    long res = mul10(number, power);
    long exp = 5;
    char *fail = apply_result(exp == res);

    printf("%d, mul10_5and0_5 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void extend_decimal_rdi_numb_rsi_len_rdx_i__5_1_0__5(){
    long rdi_numb = 5;
    long rsi_len = 1;
    long rdx_i = 0;
    long res = extend_decimal_rdi_numb_rsi_len_rdx_i(rdi_numb, rsi_len, rdx_i);
    long exp = 5;
    char *fail = apply_result(exp == res);

    printf("%d, extend_decimal_rdi_numb_rsi_len_rdx_i__5_1_0__5 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void extend_decimal_rdi_numb_rsi_len_rdx_i__4_2_1__4(){
    long rdi_numb = 4;
    long rsi_len = 2;
    long rdx_i = 1;
    long res = extend_decimal_rdi_numb_rsi_len_rdx_i(rdi_numb, rsi_len, rdx_i);
    long exp = 4;
    char *fail = apply_result(exp == res);

    printf("%d, extend_decimal_rdi_numb_rsi_len_rdx_i__4_2_1__4 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void extend_decimal_rdi_numb_rsi_len_rdx_i__3_2_0__30(){
    long rdi_numb = 3;
    long rsi_len = 2;
    long rdx_i = 0;
    long res = extend_decimal_rdi_numb_rsi_len_rdx_i(rdi_numb, rsi_len, rdx_i);
    long exp = 30;
    char *fail = apply_result(exp == res);

    printf("%d, extend_decimal_rdi_numb_rsi_len_rdx_i__3_2_0__30 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void extend_decimal_rdi_numb_rsi_len_rdx_i__9_5_0__90000(){
    long rdi_numb = 9;
    long rsi_len = 5;
    long rdx_i = 0;
    long res = extend_decimal_rdi_numb_rsi_len_rdx_i(rdi_numb, rsi_len, rdx_i);
    long exp = 90000;
    char *fail = apply_result(exp == res);

    printf("%d, extend_decimal_rdi_numb_rsi_len_rdx_i__9_5_0__90000 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void extend_decimal_rdi_numb_rsi_len_rdx_i__3_3_1__30(){
    long rdi_numb = 3;
    long rsi_len = 3;
    long rdx_i = 1;
    long res = extend_decimal_rdi_numb_rsi_len_rdx_i(rdi_numb, rsi_len, rdx_i);
    long exp = 30;
    char *fail = apply_result(exp == res);

    printf("%d, extend_decimal_rdi_numb_rsi_len_rdx_i__3_3_1__30 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void char_parse_numb_rdi_number_rsi_ptr__1_2_1null(){
    char res[2] = "0\0";
    char_parse_numb_rdi_number_rsi_ptr(1, res);
    char* exp = "1\0";
    
    char *fail = apply_result(strcmp(exp, res));
    printf("%d, char_parse_numb_rdi_number_rsi_ptr__1_2_1null - expected: %s result: %s %s\n", tests, exp, res, fail);
}

int main() 
{
    decimal_parse_1_1();
    decimal_parse_21_21();
    decimal_parse_99_99();
    decimal_parse_169_169();

    char_parse_numb_rdi_number_rsi_ptr__1_2_1null();

    str_length_abc_3();
    str_length_null_0();

    get_decimal_i_123and0_1();
    get_decimal_i_123and1_2();
    get_decimal_i_123and2_3();

    mul10_5and2_500();
    mul10_5and0_5();

    extend_decimal_rdi_numb_rsi_len_rdx_i__5_1_0__5();
    extend_decimal_rdi_numb_rsi_len_rdx_i__4_2_1__4();
    extend_decimal_rdi_numb_rsi_len_rdx_i__3_2_0__30();
    extend_decimal_rdi_numb_rsi_len_rdx_i__9_5_0__90000();
    extend_decimal_rdi_numb_rsi_len_rdx_i__3_3_1__30();



    printf("---------------------------------------\n");
    printf("\n%d/%d tests passed!\n", passed, tests);

    if(passed == tests)
        return 0;
    
    return 1;
}