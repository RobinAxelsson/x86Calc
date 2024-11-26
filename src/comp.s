global comp1
extern comp1

section .data
    message: db      "Hello World!"

section .text

comp1:
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, message
    mov     rdx, 18
    syscall

    mov     rax, 60
    mov     rdi, 0
    syscall
    ret