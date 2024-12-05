global format

extern calculate_string

; input rdi - null terminated string pointer to text calculation eg. 1+1
calculate_string:
    xor rax, rax

    ; get first digit
    mov al, [rdi]
    sub al, 0x30

    ; get second digit
    mov sil, [rdi+2]
    sub sil, 0x30

    add al, sil
    ret
