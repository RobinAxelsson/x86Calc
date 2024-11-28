global format

extern decimal_parse
extern strlen
extern get_decimal_i
extern mul10

; input rdi - null terminated string pointer to decimal number
decimal_parse:
    xor     rax, rax
    xor     rsi, rsi
    xor     r8, r8

    call strlen        ; input rdi

    cmp     rax, 1
    je      single_digit
    
    ; assume 2 digits

    mov     rsi, 0
    call get_decimal_i
    imul    rax, 10
    mov     r8, rax

    mov     rsi, 1
    call get_decimal_i
    add     rax, r8
    jmp decimal_parse_return

single_digit:
    mov     rsi, 0
    call get_decimal_i ; input rdi, index rsi
    add     r8, rax
    xchg    r8, rax

decimal_parse_return:
    ret

; ------------------

mul10:    ; input rdi number, rsi power of 10
    cmp     sil, 0
    jle     mul10_return

    imul    rdi, 10
    dec     sil
    jmp     mul10

mul10_return:
    mov     rax, rdi
    ret

; ------------------

get_decimal_i: ; address rdi, index rsi
    xor     rax, rax
    mov     al, [rdi+rsi]
    sub     al, 48        ; convert from ascii to decimal
    movsx   rax, al
    ret

; ------------------

; input string rdi
strlen:
    mov     rcx, -1
count_char:
    inc     rcx
    mov     al, [rdi + rcx]  ; Load the byte at rsi + rcx
    cmp     al, 0x00         ; Check if it's the null terminator
    jne     count_char    ; if only null digits are 0
    mov     rax, rcx
    ret