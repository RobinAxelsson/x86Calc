global  _start

section .text

_start:
    mov     rbp, rsp      ; get a base stack pointer
    push    0x30
    mov     rdi, rsp      ; func arg 1
    call print_char_irdip ; print "0"
    pop     rax           ; clean the stack

    call print_newline

    mov     r12, 0        ; r12, callee saved register, will hold our trailing fibonacci number
    mov     r13, 1        ; r13, callee saved register, will hold the higher fibonacci number
    mov     rax, r13      ; rax = dividend

push_dec_loop:
    xor     rdx, rdx
    mov     rcx, 10       ; divide by 10 to get the last decimal digit in reminder
    idiv    rcx
    ;rax = rax/rcx
    ;rdx = rax/rcx
    cmp     rdx, 0        ; if reminder is 0 we have no more digits
    jle print_dec_loop

    push    rdx           ; save our decimal digit on stack
    jmp    push_dec_loop

print_dec_loop:
    add     qword[rsp], 0x30    ; convert decimal to ASCII equivalent
    mov     rdi, rsp
    call print_char_irdip
    
    pop     rax             ; pop off the printed digit from the stack
    cmp     rsp, rbp        ; if stack pointer is back to base
    jne     print_dec_loop
    call print_newline


add_fibonacci_r12_r13:
    add     r12, r13
    xchg    r12, r13
    mov     rax, r13
    cmp     r13, 121393
    jle     push_dec_loop

exit:
    mov     rax, 60
    mov     rdi, 0
    syscall

print_newline:
    push    0xa
    mov     rdi, rsp
    call print_char_irdip
    pop     rax         ; restore the stack
    ret

print_char_irdip:       ; input arg rdi - pointer to ascii bytes
    mov     rdx, 1
    mov     rsi, rdi
    mov     rdi, 1
    mov     rax, 1
    syscall
    ret
