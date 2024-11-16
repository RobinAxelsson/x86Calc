global _start

section .text
_start:
    mov rax, 2
    mov rcx, 5

loopTest:
    imul rax, rax
    loop loopTest

; segmentation fault because no exit sys call