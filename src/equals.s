global equals

extern int_equals
extern ref_equals
extern deref_equals
extern str_equals

section .data

section .text

; just examples
; input: qword rdi, qword rsi, qword rdx
int_equals:
    xor     rax, rax
    cmp     esi, edi
    sete    al
    ret

; just example
ref_equals: ; qword 64 bit ptr
    xor     rax, rax
    cmp     rsi, rdi
    sete    al
    ret

; input: pointer rdi, pointer rsi, length rdx
deref_equals:
    dec     rdx             ; rdx is the length of the bytes to compare
    lea     rbx, [rdi+rdx]  ; get the effective address to compare
    mov     bl, [rbx]       ; read the first byte at the address into bl
    
    cmp     bl, [rsi+rdx]   ; compare the byte with the second address byte
    jne     return_false

    cmp     rdx, 0
    jg      deref_equals    ; if rdx is 0 all bytes have been iterated through
    mov     rax, 1
    ret

return_false:
    mov     rax, 0
    ret

str_equals:
    xor     rax, rax
    mov     cx, 10000
    repe cmpsb          ; Use the `repe` (repeat while equal) prefix with the `cmpsb` (compare byte) instruction.
                        ; This compares the bytes at the addresses pointed to by RSI and RDI and increments both registers after each comparison.
                        ; If the bytes are equal, it continues comparing, otherwise it stops early.
    sete    al          ; set if equal: if string comparison is equal set al to 1 (true)
    
    ret
