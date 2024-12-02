//byte_arr_tests.c
#include <stdio.h>
//main is at end of file for convinience

extern int bytes_equals(void* rdi, void* rsi, int rdx);
extern int str_equals(char* a, char* b);
extern int str_contains(char*a, char*b);

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

void bytes_equals_PtrPtrChar_1()
{
    int a = 0x215;
    int b = 0x315;
    int res = bytes_equals((void*)&a, (void*)&b, 1);
    char exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, bytes_equals_PtrPtrChar_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void bytes_equals_PtrPtrShort_1()
{
    int a = 0xABBA5;
    int b = 0x0BBA5;
    int res = bytes_equals((void*)&a, (void*)&b, 2);
    char exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, bytes_equals_PtrPtrShort_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void bytes_equals_PtrPtrShort_0()
{
    int a = 0xABBA5;
    int b = 0x0ABA5;
    int res = bytes_equals((void*)&a, (void*)&b, 2);
    char exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, bytes_equals_PtrPtrShort_0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void bytes_equals_PtrPtrInt_1()
{
    long a = 0x2BBAA2211; //use long to be able to add garbage value
    long b = 0xBBAA2211;
    int res = bytes_equals((void*)&a, (void*)&b, 4);
    char exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, bytes_equals_PtrPtrInt_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void bytes_equals_PtrPtrInt_0()
{
    long a = 0xCBAA2211;
    long b = 0xBBAA2211;
    int res = bytes_equals((void*)&a, (void*)&b, 4);
    char exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, bytes_equals_PtrPtrInt_0 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void bytes_equals_PtrPtrLong_1()
{
    long a = 0xABAA2211ABAA2211;
    long b = 0xABAA2211ABAA2211;
    char res = bytes_equals((void*)&a, (void*)&b, 8);
    char exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, bytes_equals_PtrPtrLong_1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void bytes_equals_PtrPtrLong_0()
{
    long a = 0xBBAA2211ABAA2211;
    long b = 0xABAA2211ABAA2211;
    char res = bytes_equals((void*)&a, (void*)&b, 8);
    char exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, bytes_equals_PtrPtrLong_0 - expected: %d result: %d %s\n", tests, exp, res, fail);
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

void str_contains__test_t__1()
{
    char* a = "test";
    char* b = "t";

    int res = str_contains(a, b);
    char exp = 0;
    char *fail = apply_result(exp == res);

    printf("%d, str_contains__test_t__1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

int main() {
bytes_equals_PtrPtrChar_1();
bytes_equals_PtrPtrShort_1();
bytes_equals_PtrPtrShort_0();
bytes_equals_PtrPtrInt_1();
bytes_equals_PtrPtrInt_0();
bytes_equals_PtrPtrLong_1();
bytes_equals_PtrPtrLong_0();

str_equals_HelloHello_1();
str_equals_HelloHalla_0();
str_equals_HelloMr_0();

str_contains__test_t__1();

//Summary
    printf("---------------------------------------\n");
    printf("\n%d/%d tests passed!\n", passed, tests);

    if(passed == tests)
        return 0;
    
    return 1;
}