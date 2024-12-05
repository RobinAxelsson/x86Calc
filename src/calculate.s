global format

extern calculate_string

; input rdi - null terminated string pointer to text calculation eg. 1+1
calculate_string:
    _cs:
    xor rax, rax
    xor rbx, rbx
    xor rsi, rsi

    call str_length
    mov r8, rax
    
    mov rsi, rdi ; lods read from rsi
    add rsi, r8
    dec rsi
    std          ; set direction flag

    lodsb        ; load a byte into rax
    sub rax, 0x30
    add rbx, rax
    
    lodsb
    lodsb        ; load a byte into rax

    sub rax, 0x30
    add rbx, rax

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