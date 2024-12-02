global get_arg_irdi_oraxptr_ordxl

section .text

; gets the argument att index rdi, outputs pointer rax and length rdx (should be null teminated right?)
get_arg_irdi_oraxptr_ordxl:
    add     rdi, 1      ; allow args to be 0 indexed
    imul    rdi, 8
    
    mov     rdx, [rbp+rdi]     ;movs the lower address limit
    mov     rax, [rbp+rdi+8]   ;movs the higher address limit
    push    rdx                ;saves the lower address limit

    sub     rax, rdx        ;subtract the addresses to get the length in bytes
    xchg    rax, rdx        ;changes the output so that rdx has the length
    pop     rax             ;restores the lower address limit to rax
    
    ret

