global format

extern calculate_string

; input rdi - null terminated string pointer to text calculation eg. 1+1
calculate_string:
    _cs:
    xor rax, rax
    xor rbx, rbx
    ; iterate backwards and calculate number
    ; get str length
    call str_length
    mov r8, rax
    
    mov rsi, rdi ; lods read from rsi
    cld          ; clear direction flag

    cmp r8, 4
    jne single_digits
    lodsb
    sub  rax, 0x30
    imul rax, 10
    add  rbx, rax

    single_digits:
    lodsb        ; load a byte into rax
    sub rax, 0x30
    add rbx, rax 

    lodsb
    lodsb
    sub  rax, 0x30
    add rbx, rax

    mov rax, rbx
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