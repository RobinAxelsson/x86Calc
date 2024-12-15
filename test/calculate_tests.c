#include <stdio.h>
#include <string.h>
#include "../src/calculate.h"

int passed = 0;
int tests = 0;

//--------------Test helpers------------------

char *apply_result(int boolean_result)
{
    tests++;
    char *fail = "";

    if (!boolean_result)
    {
        fail = "<------ FAILED";
    }
    else
    {
        passed++;
    }

    return fail;
}

//------------------------------------------

void calculate_string__1_plus_1__2()
{
    char *input = "1+1";
    long res = calculate_string(input);
    long exp = 2;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__1_plus_1__2 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void calculate_string__1_plus_2__3()
{
    char *input = "1+2";
    long res = calculate_string(input);
    long exp = 3;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__1_plus_2__3 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void calculate_string__1_plus_0__1()
{
    char *input = "1+0";
    long res = calculate_string(input);
    long exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__1_plus_0__1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void calculate_string__0_plus_1__1()
{
    char *input = "0+1";
    long res = calculate_string(input);
    long exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__0_plus_1__1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void calculate_string__12_plus_2__14()
{
    char *input = "12+2";
    long res = calculate_string(input);
    long exp = 14;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__12_plus_2__14 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void calculate_string__13_plus_21__34()
{
    char *input = "13+21";
    long res = calculate_string(input);
    long exp = 13 + 21;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__13_plus_21__34 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void calculate_string__10_plus_1__11()
{
    char *input = "10+1";
    long res = calculate_string(input);
    long exp = 11;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__10_plus_1__11 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void calculate_string__200_plus_1__201()
{
    char *input = "200+1";
    long res = calculate_string(input);
    long exp = 201;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__200_plus_1__201 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void calculate_string__0_plus_1000__1000()
{
    char *input = "0+1000";
    long res = calculate_string(input);
    long exp = 1000;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__0_plus_1000__1000 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void calculate_string__2_minus_1__1()
{
    char *input = "2-1";
    long res = calculate_string(input);
    long exp = 1;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__2_minus_1__1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void calculate_string__2_minus_3__neg1()
{
    char *input = "2-3";
    long res = calculate_string(input);
    long exp = -1;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__2_minus_3__neg1 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void calculate_string__2_minus_10__neg8()
{
    char *input = "2-10";
    long res = calculate_string(input);
    long exp = -8;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__2_minus_10__neg8 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void calculate_string__1000_minus_1__999()
{
    char *input = "1000-1";
    long res = calculate_string(input);
    long exp = 999;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__1000_minus_1__999 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void calculate_string__3_times_2__6()
{
    char *input = "3*2";
    long res = calculate_string(input);
    long exp = 6;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__3_times_2__6 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void calculate_string__10_div_2__5()
{
    char *input = "10/2";
    long res = calculate_string(input);
    long exp = 5;
    char *fail = apply_result(exp == res);

    printf("%d, calculate_string__10_div_2__5 - expected: %d result: %d %s\n", tests, exp, res, fail);
}


void get_decimal_from_expression__1plus2_1__2()
{
    char *input = "1+2";
    long res = get_decimal_from_expression(input, 1);
    long exp = 2;
    char *fail = apply_result(exp == res);

    printf("%d, get_decimal_from_expression__1plus2_2__2 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void get_decimal_from_expression__2plus30_1__30()
{
    char *input = "2+30";
    long res = get_decimal_from_expression(input, 1);
    long exp = 30;
    char *fail = apply_result(exp == res);

    printf("%d, get_decimal_from_expression__2plus30_1__30 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void get_decimal_from_expression__13plus30_0__13()
{
    char *input = "13+30";
    long res = get_decimal_from_expression(input, 0);
    long exp = 13;
    char *fail = apply_result(exp == res);

    printf("%d, get_decimal_from_expression__13plus30_0__13 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void get_decimal_from_expression__21000plus3220_0__21000()
{
    char *input = "21000+3220";
    long res = get_decimal_from_expression(input, 0);
    long exp = 21000;
    char *fail = apply_result(exp == res);

    printf("%d, get_decimal_from_expression__21000minus3220_0__21000 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void get_decimal_from_expression__0plus1000_1__1000()
{
    char *input = "0+1000";
    long res = get_decimal_from_expression(input, 1);
    long exp = 1000;
    char *fail = apply_result(exp == res);

    printf("%d, get_decimal_from_expression__0plus1000_1__1000 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void get_decimal_with_offset__21000plus3220_0_4__21000()
{
    char *input = "21000+3220";
    long res = get_decimal_with_offset(input, 0, 4);
    long exp = 21000;
    char *fail = apply_result(exp == res);

    printf("%d, get_decimal_with_offset__21000plus3220_0_4__21000 - expected: %d result: %d %s\n", tests, exp, res, fail);
}


void get_decimal_with_offset__2plus30_2_3__30()
{
    char *input = "2+30";
    long res = get_decimal_with_offset(input, 2, 3);
    long exp = 30;
    char *fail = apply_result(exp == res);

    printf("%d, get_decimal_with_offset__2plus30_2_3__30 - expected: %d result: %d %s\n", tests, exp, res, fail);
}


void get_decimal_with_offset__2plus243_2_4__243()
{
    char *input = "2+243";
    long res = get_decimal_with_offset(input, 2, 4);
    long exp = 243;
    char *fail = apply_result(exp == res);

    printf("%d, get_decimal_with_offset__2plus243_2_4__243 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void get_decimal_with_offset__98plus3_0_1__98()
{
    char *input = "98+3";
    long res = get_decimal_with_offset(input, 0, 1);
    long exp = 98;
    char *fail = apply_result(exp == res);

    printf("%d, get_decimal_with_offset__98plus3_0_1__101 - expected: %d result: %d %s\n", tests, exp, res, fail);
}

void get_decimal_with_offset__0plus1000_2_5__1000()
{
    char *input = "0+1000";
    long res = get_decimal_with_offset(input, 2, 5);
    long exp = 1000;
    char *fail = apply_result(exp == res);

    printf("%d, get_decimal_with_offset__0plus1000_2_5__1000 - expected: %d result: %d %s\n", tests, exp, res, fail);
}



// notes:
// null terminator is implicit in C
// char res[5] creates read and writeable memory
// char *res = "0" gives only readable memory
// strcmp: stops at first /0, 0 means equal

//------------------------------------------

int main()
{
    calculate_string__1_plus_1__2();
    calculate_string__1_plus_2__3();
    calculate_string__1_plus_0__1();
    calculate_string__0_plus_1__1();
    calculate_string__12_plus_2__14();
    calculate_string__13_plus_21__34();
    calculate_string__10_plus_1__11();
    calculate_string__200_plus_1__201();
    calculate_string__0_plus_1000__1000();

    calculate_string__2_minus_1__1();
    calculate_string__2_minus_3__neg1();
    calculate_string__2_minus_10__neg8();
    calculate_string__1000_minus_1__999();

    calculate_string__3_times_2__6();

    calculate_string__10_div_2__5();

    printf("\n");

    get_decimal_from_expression__1plus2_1__2();
    get_decimal_from_expression__2plus30_1__30();
    get_decimal_from_expression__13plus30_0__13();
    get_decimal_from_expression__21000plus3220_0__21000();
    get_decimal_from_expression__0plus1000_1__1000();

    printf("\n");

    get_decimal_with_offset__2plus30_2_3__30();
    get_decimal_with_offset__2plus243_2_4__243();
    get_decimal_with_offset__98plus3_0_1__98();
    get_decimal_with_offset__21000plus3220_0_4__21000();
    get_decimal_with_offset__0plus1000_2_5__1000();
    printf("\n");

    printf("---------------------------------------\n");
    printf("\n%d/%d tests passed!\n", passed, tests);

    if (passed == tests)
        return 0;

    return 1;
}