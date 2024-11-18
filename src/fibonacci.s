global  _start

section .text

_start:
    push    0x30
    mov     rdi, rsp
    mov     rsi, 1
    call print_str        ; print "0"
    pop     rax

    call print_newline

    mov     r12, 0        ; r12, callee saved register, will hold our trailing fibonacci number
    mov     r13, 1        ; r13, callee saved register, will hold the higher fibonacci number
    mov     rcx, 5        ; loop counter

loopFib:
    push    rcx

    call print_fib
    call print_newline

    add     r12, r13
    xchg    r12, r13

    pop     rcx
    loop loopFib

exit:
    mov     rax, 60
    mov     rdi, 0
    syscall

print_fib:
    mov     rbx, r13
    add     rbx, 0x30     ; convert number to ASCII equivalent
    push    rbx
    mov     rdi, rsp
    mov     rsi, 1
    call print_str
    pop     rax
    ret

print_newline:
    push 0xa
    mov     rdi, rsp
    mov     rsi, 1
    call print_str
    pop     rax
    ret


print_str:             ; rdi - pointer to ascii bytes, rsi - i bytes to print
    mov     rdx, rsi
    mov     rsi, rdi
    mov     rdi, 1
    mov     rax, 1
    syscall
    ret
