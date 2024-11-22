extern prints_irsip_inrdxv
extern printn_irsip
extern get_arg_irdi_oraxptr_ordxl

global _start

section .data
    intro: db "Starting main", 0xA
    introl: equ $ - intro           ;a constant not a memory address, replace at assembly time
    outro: db "End of program", 0xA
    outrol: equ $ - outro
    nullstring: db "null terminated string", 0xA, 0x0
section .text

_start:
    mov     rbp, rsp    ; set the beginning of the stack
    
    mov     rsi, intro
    mov     rdx, introl
    call prints_irsip_inrdxv

    mov     rdi, 0      ; get first input argument
    call get_arg_irdi_oraxptr_ordxl

    mov     rsi, rax
    ;rdx is set in previous function
    call prints_irsip_inrdxv
    
    mov     rsi, nullstring
    call printn_irsip

exit:
    mov     rsi, outro
    mov     rdx, outrol
    call prints_irsip_inrdxv

    mov     rax, 60
    mov     rdi, 0
    syscall