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
    mov     rdx, 2
    call print_str_rsiptr_rdxl
    pop     rax

print_arg:
    mov     rsi, [rsp + 8]     ; Load address of the first environment variable
    xor     rdx, rdx          ; Clear rdx (used for string length)
    
    find_null_terminator:
        mov     al, byte [rsi + rdx]  ; Load the byte at rsi + rdx
        cmp     al, 0x00       ; Check if it's the null terminator
        je      null_found     ; Jump if null terminator is found
        inc     rdx            ; Otherwise, increment length counter
        jmp     find_null_terminator

    null_found:
        mov     rdx, rdx       ; Set rdx to the calculated length

    call    print_str_rsiptr_rdxl

exit:
    mov     rax, 60           ; Exit syscall number
    mov     rdi, 0            ; Exit status 0
    syscall                   ; Make the syscall

print_str_rsiptr_rdxl:
    mov     rdi, 1            ; File descriptor (stdout)
    mov     rax, 1            ; Syscall number for write
    syscall                   ; Make the syscall
    ret