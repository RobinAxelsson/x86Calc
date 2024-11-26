section .data
section .bss
section .text

global _start

_start:
    ; Clear registers
    xor     rdi, rdi          ; Clear RDI (for environment pointer)

print_argv:
    mov     rbx, [rsp]
    add     rbx, 0xA30        ; add a new line and convert to ascii
    push    rbx
    mov     rsi, rsp
    mov     rdx, 2            ; only works for args that are less then 10
    call print_str_rsiptr_rdxl
    pop     rax

    xor     rbx, rbx

print_arg:
    inc     rbx
    mov     rsi, [rsp + (8*rbx)]     ; Load address of the first environment variable
    xor     rdx, rdx                 ; Clear rdx (used for string length)
    
    find_null_terminator:
        mov     al, byte [rsi + rdx]  ; Load the byte at rsi + rdx
        cmp     al, 0x00              ; Check if it's the null terminator
        je      null_found            ; Jump if null terminator is found
        inc     rdx                   ; Otherwise, increment length counter
        jmp     find_null_terminator

    null_found:

        push    rbx
        call    print_str_rsiptr_rdxl
        call    print_newline

        pop     rbx
        cmp     rbx, [rsp]
        jl      print_arg     ; if all args are printed

exit:
    mov     rax, 60           ; Exit syscall number
    mov     rdi, 0            ; Exit status 0
    syscall                   ; Make the syscall

print_str_rsiptr_rdxl:
    mov     rdi, 1            ; File descriptor (stdout)
    mov     rax, 1            ; Syscall number for write
    syscall                   ; Make the syscall
    ret

print_newline:
    push    0xA
    mov     rdx, 1
    mov     rsi, rsp
    mov     rdi, 1            ; File descriptor (stdout)
    mov     rax, 1            ; Syscall number for write
    syscall                   ; Make the syscall
    pop     rax
    ret