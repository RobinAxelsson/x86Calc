// equals_tests.c
#include <stdio.h>

extern int int_equals(int rdi, int rsi);
extern int ref_equals(int* rdi, int* rsi);
extern int deref_equals(int* rdi, int* rsi);
extern int str_equals(char* a, char* b);

char *apply_result(int boolean_result);

void int_equals_55_1();
void int_equals_56_0();
void int_equals_intMax_1();
void ref_equals_ptrptr_0();
void ref_equals_ptrptr_1();
void deref_equals_ptrptr_1();
void str_equals_HelloHello_1();
void str_equals_HelloHalla_0();
void str_equals_HelloMr_0();

int passed = 0;
int tests = 0;

int main() {

int_equals_55_1();
int_equals_56_0();
int_equals_intMax_1();

ref_equals_ptrptr_0();
ref_equals_ptrptr_1();

deref_equals_ptrptr_1();

str_equals_HelloHello_1();
str_equals_HelloHalla_0();
str_equals_HelloMr_0();

//Summary
    printf("---------------------------------------\n");
    printf("\n%d/%d tests passed!\n", passed, tests);

    return 0;
}

void int_equals_55_1()
{
    int res = int_equals(5, 5);
    int exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, int_equals_55_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void int_equals_56_0()
{
    int res = int_equals(5, 6);
    int exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, int_equals_56_0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void int_equals_intMax_1()
{
    int res = int_equals(0x7FFFFFFF, 0x7FFFFFFF);
    int exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, int_equals_intMax_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void ref_equals_ptrptr_1()
{
    int a = 5;
    int res = ref_equals((int*)&a, (int*)&a);
    int exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, ref_equals_ptrptr_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void ref_equals_ptrptr_0()
{
    int a = 5;
    int b = 5;
    int res = ref_equals((int*)&a, (int*)&b);
    int exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, ref_equals_ptrptr_0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void deref_equals_ptrptr_1()
{
    int a = 5;
    int b = 5;
    int res = deref_equals((int*)&a, (int*)&b);
    int exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, deref_equals_ptrptr_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_equals_HelloHello_1()
{
    char* a = "Hello";
    char* b = "Hello";

    int res = str_equals(a, b);
    int exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, str_equals_HelloHello_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_equals_HelloHalla_0()
{
    char* a = "Hello";
    char* b = "Halla";

    int res = str_equals(a, b);
    int exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, str_equals_HelloHalla_0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void str_equals_HelloMr_0()
{
    char* a = "Hello mr";
    char* b = "Hello ";

    int res = str_equals(a, b);
    int exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, str_equals_HelloMr_0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

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