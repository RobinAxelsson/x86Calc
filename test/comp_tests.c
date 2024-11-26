// comp_tests.c
#include <stdio.h>

extern int comp1(void);
char* apply_result(int boolean_result);

int passed = 0;
int tests = 0;

int main() {

//comp1
    int res_comp1 = comp1();
    int exp_comp1 = 0;

    int result = res_comp1 == exp_comp1;
    char *fail = apply_result(result);

    printf("%d, comp1 - exp_comp1: %d result: %d %s\n", tests, exp_comp1, res_comp1, fail);

//Summary
    printf("---------------------------------------\n");
    printf("\n%d/%d tests passed!\n", passed, tests);

    return 0;
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