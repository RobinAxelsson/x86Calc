//strings_tests.c
#include <stdio.h>
#include <string.h>
#include "../src/strings.h"
//main is at end of file for convinience

//extern int span_equals(void* rdi, void* rsi, int rdx);

int passed = 0;
int tests = 0;

char* apply_result(int boolean_result)
{
    tests++;
    char* fail = "";

    if(!boolean_result){
        fail = " <-------- FAILED";
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

//-----------------------------

void span_equals_PtrPtrChar_1()
{
    int a = 0x215;
    int b = 0x315;
    int res = span_equals((void*)&a, (void*)&b, 1);
    char exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, span_equals_PtrPtrChar_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void span_equals_PtrPtrShort_1()
{
    int a = 0xABBA5;
    int b = 0x0BBA5;
    int res = span_equals((void*)&a, (void*)&b, 2);
    char exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, span_equals_PtrPtrShort_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void span_equals_PtrPtrShort_0()
{
    int a = 0xABBA5;
    int b = 0x0ABA5;
    int res = span_equals((void*)&a, (void*)&b, 2);
    char exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, span_equals_PtrPtrShort_0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void span_equals_PtrPtrInt_1()
{
    long a = 0x2BBAA2211; //use long to be able to add garbage value
    long b = 0xBBAA2211;
    int res = span_equals((void*)&a, (void*)&b, 4);
    char exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, span_equals_PtrPtrInt_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void span_equals_PtrPtrInt_0()
{
    long a = 0xCBAA2211;
    long b = 0xBBAA2211;
    int res = span_equals((void*)&a, (void*)&b, 4);
    char exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, span_equals_PtrPtrInt_0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void span_equals_PtrPtrLong_1()
{
    long a = 0xABAA2211ABAA2211;
    long b = 0xABAA2211ABAA2211;
    char res = span_equals((void*)&a, (void*)&b, 8);
    char exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, span_equals_PtrPtrLong_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void span_equals_PtrPtrLong_0()
{
    long a = 0xBBAA2211ABAA2211;
    long b = 0xABAA2211ABAA2211;
    char res = span_equals((void*)&a, (void*)&b, 8);
    char exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, span_equals_PtrPtrLong_0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_equals_HelloHello_1()
{
    char* a = "Hello";
    char* b = "Hello";

    int res = str_equals(a, b);
    char exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, str_equals_HelloHello_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_equals_HelloHalla_0()
{
    char* a = "Hello";
    char* b = "Halla";

    int res = str_equals(a, b);
    char exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, str_equals_HelloHalla_0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_equals_HelloMr_0()
{
    char* a = "Hello mr";
    char* b = "Hello ";

    int res = str_equals(a, b);
    char exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, str_equals_HelloMr_0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_contains__t_t__1()
{
    char* a = "t";
    char* b = "t";

    int res = str_contains(a, b);
    char exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, str_contains__t_t__1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_contains__a_t__0()
{
    char* a = "a";
    char* b = "t";

    int res = str_contains(a, b);
    char exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, str_contains__a_t__0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_contains__ba_b__1()
{
    char* a = "ba";
    char* b = "b";

    int res = str_contains(a, b);
    char exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, str_contains__ba_b__1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_contains__abc_b__1()
{
    char* a = "abc";
    char* b = "b";

    int res = str_contains(a, b);
    char exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, str_contains__abc_b__1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_contains__abc_d__0()
{
    char* a = "abc";
    char* b = "d";

    int res = str_contains(a, b);
    char exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, str_contains__abc_d__0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_contains__abc_bd__0()
{
    char* a = "abc";
    char* b = "bd";

    int res = str_contains(a, b);
    char exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, str_contains__abc_bd__0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_contains__ab_abd__0()
{
    char* a = "ab";
    char* b = "abd";

    int res = str_contains(a, b);
    char exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, str_contains__ab_abd__0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_contains__ab_null__0()
{
    char* a = "ab";
    char* b = "";

    int res = str_contains(a, b);
    char exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, str_contains__ab_null__0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_contains__superlong_99__1()
{
    char* a = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz01234567899";
    char* b = "99";

    int res = str_contains(a, b);
    char exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, str_contains__superlong_99__1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_len__hello__5(){
    char* a = "hello";
    int res = str_length(a);
    char exp = 5;
    char *fail = apply_result(exp == res);

    printf("%d, str_len__hello__5 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_len__empty__0(){
    char* a = "";
    int res = str_length(a);
    char exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, str_len__empty__0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

int main() {    
span_equals_PtrPtrChar_1();
span_equals_PtrPtrShort_1();
span_equals_PtrPtrShort_0();
span_equals_PtrPtrInt_1();
span_equals_PtrPtrInt_0();
span_equals_PtrPtrLong_1();
span_equals_PtrPtrLong_0();
printf("\n");

str_equals_HelloHello_1();
str_equals_HelloHalla_0();
str_equals_HelloMr_0();
printf("\n");

str_contains__t_t__1();
str_contains__a_t__0();
str_contains__ba_b__1();
str_contains__abc_b__1();
str_contains__abc_d__0();
str_contains__abc_bd__0();
str_contains__ab_abd__0();
str_contains__ab_null__0();
str_contains__superlong_99__1();
printf("\n");

str_len__hello__5();
str_len__empty__0();
printf("\n");

convert_number_to_string__1_2__1null();
convert_number_to_string__1__not_equal_2();
convert_number_to_string__9__equal();
convert_number_to_string__69__equal();
convert_number_to_string__123456789__equal();
convert_number_to_string__0__equal();
convert_number_to_string__check_null__null_exists();
convert_number_to_string__neg1__equal();

//length tests
convert_number_to_string__1__len1();

//Summary
    printf("---------------------------------------\n");
    printf("\n%d/%d tests passed!\n", passed, tests);

    if(passed == tests)
        return 0;
    
    return 1;
}