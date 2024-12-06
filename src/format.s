global format
extern char_parse_numb_rdi_number_rsi_ptr_raxlength

char_parse_numb_rdi_number_rsi_ptr_raxlength:
    push    rbp
    mov     rbp, rsp
    xor     r8, r8      ; our negative number bool

    mov     rax, rdi    ; rax = dividend
    mov     rcx, 10     ; rcx = divisior
    cmp     rax, 0      ; check if negatve
    jge     push_decimal_char_irax

    if_negative:
    mov    r8, 1   ; input is a negative number
    neg     rax     ; print the positive number anyways

    push_decimal_char_irax:
    ; division: rax / rcx = rax + reminder rdx ; replace rcx to constant
    xor     rdx, rdx    ; clear rdx, else gives floating point exception
    idiv    rcx         ; rax = quotient, rdx = reminder, needs to be register

    add     rdx, 0x30   ; format to ASCII
    push    rdx

    cmp     rax, 0      ; nothing more to print when reminder is 0 //not true todo
    jne push_decimal_char_irax

    cmp     r8, 1      ; check input was negative 1 means negative
    jne     end_push   

    push_minus:
    mov     rdx, 0x2D
    push    rdx

    end_push:
    xor     rcx, rcx    ; counter for char position, start at most significant

    concat:
    cmp     rbp, rsp    ; check if we restored the stack aka concatinated all digits
    je push_decimal_char_return

    pop     rax         ; look for next number
    mov     [rsi+rcx], rax  ; assign char
    inc     rcx

    jmp concat

    push_decimal_char_return:
    mov     rdi, rsi
    call    str_length
    pop     rbp
    ret

;--------------------------------

; input string rdi, do not count the null char
str_length:
    mov     rcx, -1
    
    count_char:
    inc     rcx
    mov     al, [rdi + rcx]  ; Load the byte at rsi + rcx
    cmp     al, 0x00         ; Check if it's the null terminator
    jne     count_char       ; if only null digits are 0
    mov     rax, rcx
    ret