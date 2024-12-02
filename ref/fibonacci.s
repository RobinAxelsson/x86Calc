global  _start
extern printf, scanf
; int printf(const char *restrict format, ...);
; int scanf(const char *restrict format, ...);
; man -s 3 scanf/printf

section .data
    message db "Please input max Fn:", 0x0a
    outFormat db "%d", 0x0a, 0x00 ; null terminated strings expected
    inFormat db "%d", 0x00

section .bss
    userInput resb 1    ; reserves 1 byte of uninitialized data

section .text
_start:
    call printMessage   ; print intro message
    call getInput       ; get max number
    call initFib        ; set initial Fib values
    call loopFib        ; calculate Fib numbers
    call Exit           ; Exit the program

printMessage:
    mov rax, 1      ; rax: syscall number 1
    mov rdi, 1      ; rdi: fd 1 for stdout
    mov rsi,message ; rsi: pointer to message
    mov rdx, 20     ; rdx: print length of 20 bytes
    syscall         ; call write syscall to the intro message
    ret

getInput:
    sub rsp, 8
    mov rdi, inFormat  ; 1st parameter
    mov rsi, userInput ; 2nd parameter
    call scanf
    add rsp, 8
    ret

initFib:
    xor rax, rax    ; initialize rax to 0
    xor rbx, rbx    ; initialize rbx to 0
    inc rbx         ; increment rbx to 1
    ret

loopFib:
    call printFib
    add rax, rbx         ; get the next number
    xchg rax, rbx        ; swap values
    cmp rbx, [userInput] ; do rbx - 10
    js loopFib		     ; jump if result is <0
    ret

printFib:
    push rax            ; save registers
    push rbx
    mov rdi, outFormat  ; set 1st argument (print format)
    mov rsi, rbx        ; set 2nd argument (Fib number)
    call printf
    pop rbx             ; restore registers
    pop rax
    ret


Exit:
    mov rax, 60
    mov rdi, 0
    syscall