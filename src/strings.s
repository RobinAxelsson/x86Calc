extern span_equals
extern str_equals
extern str_length
extern str_contains
extern convert_number_to_string

section .data

section .text

str_contains: ; rdi nullterminated string source, rsi contains string
    ; iterate over strings with string operations, direction flag

    ; check the length of contains string rsi and copy it to r8
    push rdi
    mov rdi, rsi
    call str_length
    mov r8, rax
    pop rdi

    xor rbx, rbx
    xor rax, rax
    mov rcx, -1

    loop_compare:
    inc rcx
    mov bl, [rdi+rcx] ;bl - rbx
    
    ; check if end of string is met
    or  bl, bl
    jz  return_null_found
    
    ; check if char is equal, if not compare again
    cmp bl, [rsi]
    jne loop_compare
    sete al

    dec r8
    cmp r8, 0
    jnz loop_compare

    ret

    return_null_found:
    mov rax, 0
    ret

; ------------------

; input string rdi
str_length:
    mov     rcx, -1
    
    count_char:
    inc     rcx
    mov     al, [rdi + rcx]  ; Load the byte at rsi + rcx
    cmp     al, 0x00         ; Check if it's the null terminator
    jne     count_char       ; if only null digits are 0
    mov     rax, rcx
    ret
;--------------------

; rdi: ptr to byte array a,
; rsi: ptr to byte array b, 
; rdx: length
span_equals:
    dec     rdx             ; decrement 0 indexed
    lea     rbx, [rdi+rdx]  ; get the effective address to compare
    mov     bl, [rbx]       ; read the first byte at the address into bl
    
    cmp     bl, [rsi+rdx]   ; compare the byte with the second address byte
    jne     return_false

    cmp     rdx, 0
    jg      span_equals    ; if rdx is 0 all bytes have been iterated through
    mov     rax, 1
    ret

return_false:
    mov     rax, 0
    ret

;---------------------

str_equals:
    xor     rax, rax    ; zero out register
    xor     rcx, rcx    ; zero out the register else the 1000 will get garbage value
    mov     cx, 1000
    repe cmpsb          ; Use the `repe` (repeat while equal) prefix with the `cmpsb` (compare byte) instruction.
                        ; This compares the bytes at the addresses pointed to by RSI and RDI and increments both registers after each comparison.
                        ; If the bytes are equal, it continues comparing, otherwise it stops early.
    sete    al          ; set if equal: if string comparison is equal set al to 1 (true)
    
    ret

;----------------------

convert_number_to_string:
    push    rbp
    mov     rbp, rsp
    xor     r8, r8      ; our negative number bool

    mov     rax, rdi    ; rax = dividend
    mov     rcx, 10     ; rcx = divisior
    cmp     rax, 0      ; check if negatve
    jge     push_decimal_char_irax

    if_negative:
    mov    r8, 1   ; input is a negative number
    neg     rax     ; print the positive number anyways

    push_decimal_char_irax:
    ; division: rax / rcx = rax + reminder rdx ; replace rcx to constant
    xor     rdx, rdx    ; clear rdx, else gives floating point exception
    idiv    rcx         ; rax = quotient, rdx = reminder, needs to be register

    add     rdx, 0x30   ; format to ASCII
    push    rdx

    cmp     rax, 0      ; nothing more to print when reminder is 0 //not true todo
    jne push_decimal_char_irax

    cmp     r8, 1      ; check input was negative 1 means negative
    jne     end_push   

    push_minus:
    mov     rdx, 0x2D
    push    rdx

    end_push:
    xor     rcx, rcx    ; counter for char position, start at most significant

    concat:
    cmp     rbp, rsp    ; check if we restored the stack aka concatinated all digits
    je push_decimal_char_return

    pop     rax         ; look for next number
    mov     [rsi+rcx], rax  ; assign char
    inc     rcx

    jmp concat

    push_decimal_char_return:
    mov     rdi, rsi
    call    str_length
    pop     rbp
    ret