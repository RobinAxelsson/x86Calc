global format

extern decimal_parse
extern extend_decimal_rdi_numb_rsi_len_rdx_i
extern char_parse_numb_rdi_number_rsi_ptr

; input rdi - null terminated string pointer to decimal number
decimal_parse:
    xor     rax, rax
    mov     r8, rdi  ; r8 is the pointer
    xor     r9, r9   ; length of string 3
    xor     r10, r10 ; sum
    
    mov     rdi, r8
    call str_length     ; input string rdi
    
    mov     r9, rax   ; r9 = 3 length
    xor     rcx, rcx
    
    sum_digits:

    mov     rdi, r8
    mov     rsi, rcx
    call    get_decimal_i ; address rdi, index rsi

    mov     rdi, rax
    mov     rsi, r9
    mov     rdx, rcx
    call    extend_decimal_rdi_numb_rsi_len_rdx_i
    add     r10, rax

    inc     rcx
    cmp     rcx, r9
    jne     sum_digits
    
    mov     rax, r10
    ret

; ------------------
extend_decimal_rdi_numb_rsi_len_rdx_i:
    xor     rax, rax
    sub     rsi, rdx
    dec     rsi

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
str_length:
    mov     rcx, -1
count_char:
    inc     rcx
    mov     al, [rdi + rcx]  ; Load the byte at rsi + rcx
    cmp     al, 0x00         ; Check if it's the null terminator
    jne     count_char    ; if only null digits are 0
    mov     rax, rcx
    ret

; ------------------

char_parse_numb_rdi_number_rsi_ptr:
    push    rbp
    mov     rbp, rsp
    
    mov     rax, rdi    ; rax = dividend
    mov     rcx, 10     ; rcx = divisior

push_decimal_char_irax:
    ; division: rax / rcx = rax + reminder rdx ; replace rcx to constant
    xor     rdx, rdx    ; clear rdx, else gives floating point exception
    idiv    rcx         ; rax = quotient, rdx = reminder, needs to be register

    add     rdx, 0x30   ; format to ASCII
    push    rdx

    cmp     rax, 0      ; nothing more to print when reminder is 0 //not true todo
    jne push_decimal_char_irax

    xor     rcx, rcx    ; counter for char position, start at most significant
concat:
    cmp     rbp, rsp    ; check if we restored the stack aka concatinated all digits
    je push_decimal_char_return

    pop     rax         ; look for next number
    mov     [rsi+rcx], rax  ; assign char
    inc     rcx

    jmp concat

push_decimal_char_return:
    mov     rax, rsi ; we dont need to add null if [rsi] points to only 0
    pop     rbp
    ret