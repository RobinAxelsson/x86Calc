global format

extern decimal_parse

; input rdi - null terminated string pointer to decimal number
decimal_parse:
    xor     rax, rax
    xor     rsi, rsi
    mov     rcx, -1          ; the length of the digits

count_to_null:
    inc     rcx
    mov     al, [rdi + rcx]  ; Load the byte at rsi + rcx
    cmp     al, 0x00         ; Check if it's the null terminator
    jne     count_to_null    ; if only null digits are 0

get_decimal:
    dec     rcx            ; decrement to end with zero offset
    mov     sil, [rdi+rcx]
    sub     sil, 48        ; convert from ascii to decimal
    movsx   rsi, sil

    push    rcx
    cmp     rcx, 0         ; lowest digit
    je      add_decimal

multiply_by_10:
    imul    rsi, 10
    dec     rcx
    cmp     rcx, 0
    jne    multiply_by_10

add_decimal:
    pop     rcx
    add     rax, rsi

    cmp     rcx, 0
    jg      get_decimal
    ret

