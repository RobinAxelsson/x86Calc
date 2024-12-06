//strings_tests.c
#include <stdio.h>
//main is at end of file for convinience

extern int span_equals(void* rdi, void* rsi, int rdx);
extern int str_equals(char* a, char* b);
extern int str_contains(char*a, char*b);
extern int str_length(char*a);

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

int main() {
span_equals_PtrPtrChar_1();
span_equals_PtrPtrShort_1();
span_equals_PtrPtrShort_0();
span_equals_PtrPtrInt_1();
span_equals_PtrPtrInt_0();
span_equals_PtrPtrLong_1();
span_equals_PtrPtrLong_0();

str_equals_HelloHello_1();
str_equals_HelloHalla_0();
str_equals_HelloMr_0();

str_contains__t_t__1();
str_contains__a_t__0();
str_contains__ba_b__1();
str_contains__abc_b__1();
str_contains__abc_d__0();
str_contains__abc_bd__0();
str_contains__ab_abd__0();
str_contains__ab_null__0();
str_contains__superlong_99__1();

str_len__hello__5();

//Summary
    printf("---------------------------------------\n");
    printf("\n%d/%d tests passed!\n", passed, tests);

    if(passed == tests)
        return 0;
    
    return 1;
}