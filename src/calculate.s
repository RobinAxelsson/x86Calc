global format

extern calculate_string

; input rdi - null terminated string pointer to text calculation eg. 1+1
calculate_string:
    xor rax, rax
    xor rbx, rbx
    xor rsi, rsi

    call str_length
    mov r8, rax
    
    mov rsi, rdi ; lods read from rsi
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
str_length:
    mov     rcx, -1
    
    count_char:
    inc     rcx
    mov     al, [rdi + rcx]  ; Load the byte at rsi + rcx
    cmp     al, 0x00         ; Check if it's the null terminator
    jne     count_char       ; if only null digits are 0
    mov     rax, rcx
    ret

; ------------------