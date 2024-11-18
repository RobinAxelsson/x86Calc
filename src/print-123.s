global  _start
section .text

_start: 
    mov     rax, 123    ; add dividend as input to function
    push    0           ; adding a null byte to know when to stop printing

push_chars:
    xor     rdx, rdx    ; clear rdx, else gives floating point exception
    mov     rcx, 10     ; rax = dividend, rcx = divisior
    idiv    rcx         ; rax = quotient, rdx = reminder

    cmp     rdx, 0      ; nothing more to print
    je print

    add     rdx, 48     ; format to ASCII
    push    rdx
    
    jmp push_chars

print:
    mov     rax, [rsp]  ; check if stack has ascii number
    cmp     rax, 0
    jle exit

    mov     rax, 1      ; print stack ascii number
    mov     rdi, 1
    mov     rsi, rsp
    mov     rdx, 1
    syscall

    pop     rax         ; look for next number

    jmp print

exit:
    mov     rax, 60
    mov     rdi, 0
    syscall