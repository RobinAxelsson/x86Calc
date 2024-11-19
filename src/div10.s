global  _start

section .data

section .text

_start:
    mov     rax, 12
    call get_dividend_reminder_irax_orax_ordx
    jmp assert_irax_irdx

exit:
    mov     rax, 60
    mov     rdi, 0
    syscall

get_dividend_reminder_irax_orax_ordx:
    xor     rdx, rdx
    mov     rcx, 10       ; divide by 10 to get the last decimal digit in reminder
    idiv    rcx
    ;rax = rax/rcx
    ;rdx = rax/rcx
    cmp     rdx, 0        ; if reminder is 0 we have no more digits
    ret

error:
    mov     rax, 60
    mov     rdi, 1
    syscall

assert_irax_irdx:
    cmp     rax, 1
    jne error
    cmp     rdx, 2
    jne error

    jmp exit


