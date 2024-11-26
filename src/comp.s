global int_equals
extern int_equals
extern ref_equals
extern deref_equals

section .data

section .text

int_equals:
    xor     rax, rax
    cmp     rsi, rdi
    sete    al
    ret

ref_equals:
    xor     rax, rax
    cmp     rsi, rdi
    sete    al
    ret

deref_equals:
    xor     rax, rax
    cmp     rsi, rdi
    sete    al
    ret