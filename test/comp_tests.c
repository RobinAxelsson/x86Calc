// comp_tests.c
#include <stdio.h>

extern int int_equals(int rdi, int rsi);
extern int ref_equals(int* rdi, int* rsi);
char *apply_result(int boolean_result);

void int_equals_55_1();
void int_equals_56_0();
void ref_equals_ptrptr_0();
void ref_equals_ptrptr_1();

int passed = 0;
int tests = 0;

int main() {

int_equals_55_1();
int_equals_56_0();

ref_equals_ptrptr_0();
ref_equals_ptrptr_1();

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

    printf("%d, int_equals - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void int_equals_56_0()
{
    int res = int_equals(5, 6);
    int exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, int_equals - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void ref_equals_ptrptr_0()
{
    int a = 5;
    int res = ref_equals((int*)&a, (int*)&a);
    int exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, ref_equals - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void ref_equals_ptrptr_1()
{
    int a = 5;
    int b = 5;
    int res = ref_equals((int*)&a, (int*)&b);
    int exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, ref_equals - expected: %d result: %d %s a: %d, b: %d\n", tests, exp, res, fail, a, b);
}

char* apply_result(int boolean_result){
    tests++;
    char* fail = "";
    printf("bool: %d\n", boolean_result);

    if(!boolean_result){
        fail = " - FAILED";
    }
    else {
        passed++;
    }

    return fail;
}