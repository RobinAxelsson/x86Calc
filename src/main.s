global _start
extern str_contains
extern calculate_string
extern convert_number_to_string
extern sys_print
extern sys_exit
extern sys_error_exit

BUFFER_LEN equ 5

section .data
    plus db "+", 0x00
    minus db "-", 0x00
    _mul db "*", 0x00
    _div db "/", 0x00
    two db "2", 0x00


section .bss ; uninitialized data
    result_buffer resb BUFFER_LEN

section .text

_start:
    mov rbp, rsp

    ; read the argv length value on the stack
    ; exit if less then 2
    mov rax, [rbp]
    cmp rax, 2
    jl sys_error_exit

    mov rdi, [rbp+16] ; load the input argument in rdi

    mov rsi, plus
    call str_contains
    cmp rax, 1
    je addition

    mov rsi, _mul
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
    jmp sys_error_exit

addition:
    call calculate_string
    mov rdi, rax
    mov rsi, result_buffer
to_text:
    call convert_number_to_string
print_:
    mov rdi, rax ; length
    mov rsi, result_buffer ; byte ptr
    call sys_print
    jmp sys_exit

subtraction:
    mov rdi, 1
    mov rsi, two
    call sys_print
    jmp sys_exit

multiplication:
    mov rdi, 1
    mov rsi, two
    call sys_print
    jmp sys_exit

division:
    mov rdi, 1
    mov rsi, two
    call sys_print
    jmp sys_exit