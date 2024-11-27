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

; input: qword rdi, qword rsi, qword rdx
deref_equals:
    xor     rax, rax

    cmp     rdx, 1
    je      byte_equals

    cmp     rdx, 2
    je      word_equals

    cmp     rdx, 4
    je      dword_equals

    cmp     rdx, 8
    je      qword_equals

byte_equals: ; 8 bits
    mov     sil, [rsi]  ; memory addresses are 8 bytes
    mov     dil, [rdi]  ; dil, sil 8bits
    cmp     sil, dil
    sete    al
    ret

word_equals: ; 16 bits
    mov     si, [rsi]  ; memory addresses are 8 bytes
    mov     di, [rdi]  ; di, rdi 16 bits
    cmp     si, di
    sete    al
    ret

dword_equals:
    mov     esi, [rsi]  ; memory addresses are 8 bytes, but int is 4 bytes
    mov     edi, [rdi]  ; edi, rdi 32 bits
    cmp     esi, edi
    sete    al
    ret

qword_equals:
    mov     rsi, [rsi]  ; memory addresses are 8 bytes, but int is 4 bytes
    mov     rdi, [rdi]  ; rdi, rsi 64 bits
    cmp     rsi, rdi
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
