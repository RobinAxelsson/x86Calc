global  _start

section .text

_start:
    push    0x30
    mov     rdi, rsp      ; func arg 1
    call print_char       ; print "0"
    pop     rax           ; clean the stack

    call print_newline

    mov     r12, 0        ; r12, callee saved register, will hold our trailing fibonacci number
    mov     r13, 1        ; r13, callee saved register, will hold the higher fibonacci number
    mov     rax, r13      ; rax = dividend

push_dec_loop:
    xor     rdx, rdx
    mov     rcx, 10     ; rcx = divisior
    idiv    rcx         ; rax = qoutient
    push    rdx         ; save reminder on stack
    cmp     rdx, 0
    jne     push_dec_loop

print_dec_loop:
    add     byte [rsp], 0x30    ; convert decimal to ASCII equivalent
    mov     rdi, rsp
    call print_char
    
    pop     rax
    cmp     byte [rsp], 0
    jnz     print_dec_loop
    call print_newline

add_fibonacci:
    add     r12, r13
    xchg    r12, r13
    mov     rax, r13     ; rax = dividend
    cmp     r13, 100
    jle     push_dec_loop

exit:
    mov     rax, 60
    mov     rdi, 0
    syscall

print_newline:
    push    0xa
    mov     rdi, rsp
    call print_char
    pop     rax         ; clean the stack
    ret

print_char:             ; rdi - pointer to ascii bytes
    mov     rdx, 1
    mov     rsi, rdi
    mov     rdi, 1
    mov     rax, 1
    syscall
    ret
