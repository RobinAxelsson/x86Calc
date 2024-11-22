global prints_irsip_inrdxv
global printn_irsip

section .text

prints_irsip_inrdxv:
    push    rbp
    mov     rax, 1
    mov     rdi, 1
    syscall

    cmp rax, 0
    jl syscall_failed

    pop rbp
    ret

printn_irsip:   ; prints a nullterminated string
    push    rbp

find_null_terminator:
    mov     al, byte [rsi + rdx]  ; Load the byte at rsi + rdx
    cmp     al, 0x00       ; Check if it's the null terminator
    je      null_found     ; Jump if null terminator is found
    inc     rdx            ; Otherwise, increment length counter
    jmp     find_null_terminator

null_found:
    mov     rdx, rdx       ; Set rdx to the calculated length

    call prints_irsip_inrdxv
    pop     rbp
    ret


syscall_failed:
    mov rax, 60       ; Exit
    mov rdi, 1        ; Error code
    syscall