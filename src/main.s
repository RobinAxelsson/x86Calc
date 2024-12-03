global _start
extern str_contains

%macro print 2
    mov rax, 1  ; sys_write
    mov rdi, 1  ; std_out
    mov rsi, %1 ; byte ptr
    mov rdx, %2 ; length
    syscall
%endmacro

section .data
    plus db "+", 0x00
    minus db "-", 0x00
    sign db "*", 0x00
    _div db "/", 0x00
    two db "2", 0x00

section .text

_start:
    mov rbp, rsp

    ; read the argv length value on the stack
    ; exit if less then 2
    mov rax, [rbp]
    cmp rax, 2
    jl error_exit

    mov rdi, [rbp+16] ; load the input argument in rdi

    mov rsi, plus
    call str_contains
    cmp rax, 1
    je addition

    mov rsi, sign
    call str_contains
    cmp rax, 1
    je multiplication

    mov rsi, minus
    call str_contains
    cmp rax, 1
    je subtraction

    mov rsi, _div
    call str_contains
    cmp rax, 1
    je division

error_exit:
    mov     rax, 60
    mov     rdi, 1
    syscall

addition:
    print two, 1
    jmp exit

subtraction:
    print two, 1
    jmp exit

multiplication:
    print two, 1
    jmp exit

division:
    print two, 1
    jmp exit

exit:
    mov     rax, 60
    mov     rdi, 0
    syscall