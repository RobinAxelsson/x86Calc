global _start
extern str_contains ; rdi nullterminated string source, rsi contains string
extern length_argv

section .data
    plus db "+", 0x00

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

    ; check if + in second argument
    mov rdi, [rbp+16]
    mov rsi, plus
    call str_contains
    cmp rax, 1
    jne error_exit

    ; normal exit
    mov     rax, 60
    mov     rdi, 0
    syscall


error_exit:
    mov     rax, 60
    mov     rdi, 1
    syscall
    