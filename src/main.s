global _start

section .data
section .text


_start:
    

error_exit:
    mov     rax, 60
    mov     rdi, 1
    syscall