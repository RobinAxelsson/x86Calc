global format

extern calculate_string

; input rdi - null terminated string pointer to text calculation eg. 1+1
calculate_string:
    xor rax, rax

    ; iterate backwards and calculate number
    ; get str length
    ; call str_length
    
    mov rsi, rdi ; lods read from rsi
    cld          ; clear direction flag
iterate_bytes:
    lodsb        ; load a byte into rax
    sub rax, 0x30
    mov rbx, rax 

    lodsb
    lodsb
    sub rax, 0x30

    add rax, rbx
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