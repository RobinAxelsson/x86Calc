global  _start

section .data

section .text

_start: 
    mov     rax, 123     ; add dividend as input to function

    call push_chars

    call print_stack
    
    mov     rax, 60     ; exit sys call
    mov     rdi, 0
    syscall

push_chars:
    pop     rbp

    xor     rdx, rdx
    mov     rcx, 10
    idiv    rcx
    add     rdx, 48
    push    rdx

    xor     rdx, rdx
    mov     rcx, 10
    idiv    rcx
    add     rdx, 48
    push    rdx

    xor     rdx, rdx
    mov     rcx, 10
    idiv    rcx
    add     rdx, 48
    push    rdx

    ; idiv    10
    ; add     rdx, 48
    ; push    rdx

    push    rbp
    ret

print_stack:
    pop rbp

    mov     rax, 1
    mov     rdi, 1
    mov     rsi, rsp
    mov     rdx, 1
    syscall

    pop     rax

    mov     rax, 1
    mov     rdi, 1
    mov     rsi, rsp
    mov     rdx, 1
    syscall

    pop     rax
    
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, rsp
    mov     rdx, 1
    syscall
    
    push rbp
    ret