global format
extern str_length
extern calculate_string
extern get_decimal_from_expression
extern get_decimal_with_offset

get_decimal_from_expression:
    cmp rsi, 0
    je first_decimal

    second_decimal:
    mov rsi, 2

    first_decimal:
    call get_decimal_i

    ret_:
    ret

get_second_decimal_start:
    mov rcx, -1
    load_next_char:
    lodsb   ; get char into rax
    inc rcx

    ; if rax != digit return
    cmp rax, 0x30
    jge load_next_char

    ; get first digit after
    inc rcx
    mov rax, rcx
    ret

get_second_decimal_end:
    call str_length
    dec rax
    ret

get_decimal_with_offset:
gdwo:
    xor rbx, rbx
    ;rdi pointer
    ;rsi offset start
    ;rdx offset end

    first_digit:
    call get_decimal_i
    imul rax, 10
    add rbx, rax
    
    second_digit:
    mov rsi, rdx
    call get_decimal_i
    add rax, rbx
    ret

get_decimal_i: ; address rdi, index rsi
    xor     rax, rax
    mov     al, [rdi+rsi]
    sub     al, 0x30        ; convert from ascii to decimal
    movsx   rax, al
    ret

; input rdi - null terminated string pointer to text calculation eg. 1+1
calculate_string:
    xor rax, rax ; used with lodsb
    xor rbx, rbx ; sum output
    xor rsi, rsi ; lods read from rsi

    call str_length
    mov r8, rax
    
    mov rsi, rdi
    add rsi, r8
    dec rsi
    std          ; set direction flag

    mov rcx, 0    ; loop i
    
    load_byte:
    lodsb         ; load a byte into rax
    inc rcx
    
    check_byte:
    ; if rax >= 0x30 (ascii digit)
    cmp rax, 0x30
    jge rax_digit
    
    rax_delimiter:
    mov rcx, 0      ; zero out 10s place
    cmp rax, '-'
    jne positive_number

    negative_number:
    neg rbx

    positive_number:
    jmp load_byte

    rax_digit:
    sub rax, 0x30 ; convert to digit

    ; if rcx > 1 multiply else add_rax
    cmp rcx, 1
    je add_rax
    
    push rcx
    multiply:
    ; if 10s place is more then 1 multiply
    imul rax, 10
    dec rcx
    cmp rcx, 1
    jg multiply
    pop rcx

    add_rax:
    add rbx, rax
    xor rax, rax
    
    ; if byte pointer is less then input string pointer return
    compare_pointers:
    cmp rsi, rdi
    jge load_byte

    return:
    mov rax, rbx
    cld
    ret

; input string rdi
; str_length:
;     mov     rcx, -1
    
;     count_char:
;     inc     rcx
;     mov     al, [rdi + rcx]  ; Load the byte at rsi + rcx
;     cmp     al, 0x00         ; Check if it's the null terminator
;     jne     count_char       ; if only null digits are 0
;     mov     rax, rcx
;     ret

; ------------------