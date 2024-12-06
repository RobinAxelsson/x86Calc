extern sys_print
extern sys_exit
extern sys_error_exit

section .text

; rdi = length, rsi = pointer
sys_print:
    mov rdx, rdi
    ;mov rsi - the pointer
    mov rax, 1  ; sys_write
    mov rdi, 1  ; std_out
    syscall
    ret

sys_exit:
    mov     rax, 60
    mov     rdi, 0
    syscall

sys_error_exit:
    mov     rax, 60
    mov     rdi, 1
    syscall