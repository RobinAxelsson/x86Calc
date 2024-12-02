global byte_arr ; Utility functions for byte arrays

extern bytes_equals
extern nullterm_equals
extern contains_seq

section .data

section .text

; 
contains_seq:

    ret

; rdi is pointer to the byte array, rdx is the length
bytes_equals:
    dec     rdx             ; decrement 0 indexed
    lea     rbx, [rdi+rdx]  ; get the effective address to compare
    mov     bl, [rbx]       ; read the first byte at the address into bl
    
    cmp     bl, [rsi+rdx]   ; compare the byte with the second address byte
    jne     return_false

    cmp     rdx, 0
    jg      bytes_equals    ; if rdx is 0 all bytes have been iterated through
    mov     rax, 1
    ret

return_false:
    mov     rax, 0
    ret

nullterm_equals:
    xor     rax, rax
    mov     cx, 10000
    repe cmpsb          ; Use the `repe` (repeat while equal) prefix with the `cmpsb` (compare byte) instruction.
                        ; This compares the bytes at the addresses pointed to by RSI and RDI and increments both registers after each comparison.
                        ; If the bytes are equal, it continues comparing, otherwise it stops early.
    sete    al          ; set if equal: if string comparison is equal set al to 1 (true)
    
    ret
