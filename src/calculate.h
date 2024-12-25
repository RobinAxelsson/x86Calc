#ifndef CALCULATE_H
#define CALCULATE_H

long calculate_string(char *string);
long get_decimal_from_expression(char *expression, long index);
long get_decimal_with_offset(char *expression, long start, long end); //inclusive
long count_expressions(char *expression);

#endif //CALCULATE_H