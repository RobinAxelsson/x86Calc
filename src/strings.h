#ifndef STRINGS_H
#define STRINGS_H

int span_equals(void* a, void* b, int len);
int str_equals(char* a, char* b);
int str_contains(char*a, char*b);
int str_length(char*a);
long convert_number_to_string(long number, char* dest);

#endif //STRINGS_H