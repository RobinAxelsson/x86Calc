global  _start
extern  printf

; solution to this one was to align the stack
; if the rsp address ends with 8 it is not aligned
; if the rsp address ends with 0 it is aligned
section .data
    outFormat db  "It's %s", 0x0a, 0x00
    message db "Aligned!", 0x0a

section .text
_start:
    call print          ; print string
    call Exit           ; Exit the program

print:
    sub rsp, 8
    mov rdi, outFormat  ; set 1st argument (Print Format)
    mov rsi, message    ; set 2nd argument (message)
    call printf         ; printf(outFormat, message)
    add rsp, 8
    ret

Exit:
    mov rax, 60
    mov rdi, 0
    syscall