global  _start

section .text

_start:
    xor r8, r8 ; zero initialize
    xor r9, r9
    mov rcx, 10   ; loop count
    inc r9      ; r9 = 1
    jmp _count

    ;prepare system call
    mov rdi, 1 ; file descriptor standard out
    mov rax, 1 ; syscall for write
    mov rdx, 1 ; length of number to print

_count:
    add r8, r9
    push r8
    mov rsi, [rsp] ;syscall needs a pointer to the message to print
    pop r15

    add r9, r8
    push r9
    mov rsi, [rsp]
    pop r15

    dec rcx
    cmp rcx, 0
    jne _count
    
    ; exit the function
    mov rax, 60  ; syscall number for exit
    mov rdi, 0 ; status 0
    syscall