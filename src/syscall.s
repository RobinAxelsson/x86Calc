extern sys_print
extern sys_exit
extern sys_error_exit
extern sys_read_file

section .text

; rdi = length, rsi = pointer
sys_print:
    mov rdx, rdi
    ;mov rsi - the pointer
    mov rax, 1  ; sys_write
    mov rdi, 1  ; std_out
    syscall
    ret

sys_exit:
    mov     rax, 60
    mov     rdi, 0
    syscall

sys_error_exit:
    mov     rax, 60
    mov     rdi, 1
    syscall

; rdi - pointer to file path
; rsi - pointer to buffer
; rdx - bytes to read
sys_read_file:
    push rsi ; pointer to buffer

    ; OPEN
    mov rax, 2  ; syscall no
    mov rsi, 0 ; readonly flag
      ; rdi ; file path
    syscall
    ; returns filedescriptor in rax
    ; or 

    ; READ
    mov rdi, rax ; move file descriptor to rdi
    mov rax, 0   ; syscall no

    pop rsi ; Pointer to the buffer
      ; rdx ; bytes to read
    syscall
    ; returns the bytes actually read in rax
    ; -1 for error

    ret

; error handling missing see table in refs for error codes
