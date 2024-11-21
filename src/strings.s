global prints_irsip_inrdxv

section .text

prints_irsip_inrdxv:
    mov     rax, 1
    mov     rdi, 1
    syscall

    cmp rax, 0
    jl syscall_failed

    ret

syscall_failed:
    mov rax, 60       ; Exit
    mov rdi, 1        ; Error code
    syscall