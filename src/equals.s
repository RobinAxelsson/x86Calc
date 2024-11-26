global int_equals

extern int_equals
extern ref_equals
extern deref_equals
extern str_equals

section .data

section .text

int_equals:
    xor     rax, rax
    cmp     rsi, rdi
    sete    al
    ret

ref_equals: ; qword 64 bit ptr
    xor     rax, rax
    cmp     rsi, rdi
    sete    al
    ret

deref_equals: ; dword int
    xor     rax, rax
    mov     esi, [rsi]  ; memory addresses are 8 bytes, but int is 4 bytes
    mov     edi, [rdi]
    cmp     esi, edi
    sete    al
    ret

str_equals:
    xor     rax, rax
    mov     cx, 10000
    ; iterates until end of string or end of cx
    repe cmpsb ;repz cmps BYTE PTR ds:[rsi], BYTE PTR es:[rdi]
    sete    al
    
    ret

; bytes_equals:
