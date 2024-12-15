#include <stdio.h>
#include <string.h>
#include "../src/syscall.h"

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

void sys_read_file__testfile__Assembly_rocks(){
    char buffer[16];
    char *filepath = "./test/test-read.txt";
    int read_bytes = sys_read_file(filepath, buffer, 16);
    char* exp = "Assembly rocks!";
    int str_equal = strcmp(buffer, exp) == 0;
    char *fail = apply_result(str_equal);
    printf("%d, convert_number_to_string__1_2__1null - expected: %s result: %s %s\n", tests, exp, buffer, fail);
}

int main()
{
    sys_read_file__testfile__Assembly_rocks();

//Summary
    printf("---------------------------------------\n");
    printf("\n%d/%d tests passed!\n", passed, tests);

    if(passed == tests)
        return 0;
    
    return 1;
}