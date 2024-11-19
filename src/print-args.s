global  _start

section .data
    arg: db      "length-args: "
    argl: db     13

section .text

_start:
    mov     rdx, [argl]      ; length of string
    mov     rsi, arg
    call print_str_rsiptr_rdxl

print_arg_length:
    add     rdi, 0x30   ; convert to ascii
    push    rdi
    mov     rdx, 2      ; length of string
    mov     rsi, rsp
    call print_str_rsiptr_rdxl
    pop     rax         ; pop off the ascii char
    
    call print_newline

print_arg_1:
    pop     rbp         ; save the stack
    mov     rdx, 16      ; length of string
    mov     rsi, rsp
    call print_str_rsiptr_rdxl
    call print_newline

exit:
    mov     rax, 60
    mov     rdi, 0
    syscall

print_newline:
    push 0xa
    mov rsi, rsp
    mov rdx, 1
    call print_str_rsiptr_rdxl
    pop rax
    ret

print_str_rsiptr_rdxl:
    mov     rdi, 1
    mov     rax, 1
    syscall
    ret