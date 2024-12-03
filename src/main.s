global _start
extern str_contains

section .data
    plus db "+", 0x00
    minus db "-", 0x00
    sign db "*", 0x00
    _div db "/", 0x00

section .text

; example stack for input arguments
; 0x00007fffffffdea0│+0x0000: 0x0000000000000002   ← $rsp, $rbp
; 0x00007fffffffdea8│+0x0008: 0x00007fffffffe213  →  "/home/kali/rax/x86-assembly/output/x86Calc"
; 0x00007fffffffdeb0│+0x0010: 0x00007fffffffe23e  →  0x4c45485300312b31 ("1+1"?)

_start:
    mov rbp, rsp

    ; read the argv length value on the stack
    ; exit if less then 2
    mov rax, [rbp]
    cmp rax, 2
    jl error_exit

    mov rdi, [rbp+16] ; load the input argument in rdi

    mov rsi, plus
    call str_contains ; rdi nullterminated string source, rsi containee-string
    cmp rax, 1
    je addition

    mov rsi, sign
    call str_contains ; rdi nullterminated string source, rsi containee-string
    cmp rax, 1
    je multiplication

    mov rsi, minus
    call str_contains ; rdi nullterminated string source, rsi containee-string
    cmp rax, 1
    je subtraction

    mov rsi, _div
    call str_contains ; rdi nullterminated string source, rsi containee-string
    cmp rax, 1
    je division

error_exit:
    mov     rax, 60
    mov     rdi, 1
    syscall

addition:
    jmp exit

subtraction:
    jmp exit

multiplication:
    jmp exit

division:
    jmp exit

exit:
    mov     rax, 60
    mov     rdi, 0
    syscall