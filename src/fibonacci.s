global  _start

section .text

_start:
    xor rax, rax
    xor rbx, rbx
    inc rbx
    add rax, rbx

loopFib:
    add rax, rbx    ; get the next number
    xchg rax, rbx   ; swap values
    cmp rbx, 10     ; rbx - 10 sets flags
    js loopFib      ; jump if smaller

; _start:
;     xor r8, r8          ; zero initialize
;     xor r9, r9
;     mov rcx, 10         ; times to loop
;     inc r9              ; r9 = 1
;     call _l

;     mov rax, 60         ; syscall number for exit
;     mov rdi, 0          ; status 0
;     syscall

; _l:
;     ; add the values
;     mov rax, r9
;     add rax, r8

;     call _print

;     ; set up next values
;     mov r8, r9
;     mov r9, rax

;     dec rcx
;     cmp rcx, 0

;     jne _l
;     ret

; _print:
;     mov rbx, 10
;     div rbx             ; dividend in rax, reminder in rdx

;     mov r10, rax            ; store dividend 

;     mov rax, rdx        ; get the reminder

;     add rax, 48         ; to match the ascii table

;     shl rax, 8
;     add rax, 32         ; add a space
    
;     push rax            ; rsp -> rax

;     mov rax, 1          ; syscall number for write
;     mov rbx, 1          ; file descriptor (stdout)
;     mov rsi, rsp        ; rsp -> rax
;     mov rdx, 2          ; length of the buffer
    
;     push rcx            ; rcx changes after syscall

;     syscall

;     pop rcx
;     pop rax

;     mov rax, r10

;     ret
