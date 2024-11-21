extern prints_irsip_inrdxv
global _start

section .data
    intro: db "Starting main", 0xA
    introl: equ $ - intro           ;a constant not a memory address, replace at assembly time
    outro: db "End of program", 0xA
    outrol: equ $ - intro
section .text

_start:
    mov     rsi, intro
    mov     rdx, introl
    call prints_irsip_inrdxv

exit:
    mov     rsi, outro
    mov     rdx, outrol
    call prints_irsip_inrdxv

    mov     rax, 60
    mov     rdi, 0
    syscall