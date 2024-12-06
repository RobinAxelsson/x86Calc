global format
extern str_length
extern calculate_string
extern get_decimal_from_expression
extern get_decimal_with_offset

get_decimal_from_expression:
    ; rdi is pointer to expression
    ; rsi is the number index eg 10+22, 10 rsi=0, 22 rsi=1 
    xor rax, rax
    xor rbx, rbx ; used for delimiter offset
    xor rcx, rcx ; used for end of string

    push rsi
    ; rdi is pointer to expression
    call index_get_delimiter
    mov rbx, rax

    ; rdi is pointer to expression
    call index_last_digit
    mov rcx, rax

    pop rsi
    cmp rsi, 0
    je first_decimal

    second_decimal:
    inc rbx
    mov rsi, rbx ; get start of second decimal
    mov rdx, rcx ; get end of second decimal

    jmp _ret

    first_decimal:
    mov rsi, 0   ; get start of first decimal
    dec rbx
    mov rdx, rbx ; get end of first decimal

    _ret:
    ;rdi pointer
    ;rsi offset start
    ;rdx offset end
    call get_decimal_with_offset
    ret

; input rdi pointer
index_get_delimiter:
    mov rcx, -1
    mov rsi, rdi
    load_next_char:
    lodsb   ; get char into rax
    inc rcx

    ; if rax != digit return
    cmp rax, 0x30
    jge load_next_char

    ; get first digit after
    mov rax, rcx
    ret

index_last_digit:
    call str_length
    dec rax
    ret

;rdi pointer
;rsi offset start
;rdx offset end
get_decimal_with_offset:
_d2:
    xor rax, rax
    xor rbx, rbx ; used to sum
    lea r8, [rdi+rsi] ; start pointer
    lea r9, [rdi+rdx] ; end pointer

    std ; set direction flag (reverse byte lookup)
    mov rsi, r9
    mov rcx, 0
    convert_decimal:

    ; return if load pointer is equal to start pointer
    is_pointers_equal:
    cmp rsi, r8
    jl _return

    _load_byte:
    lodsb         ; load a byte into rax from rsi pointer and decrements rsi
    
    _convert:
    sub al, 0x30    ; convert to number
    movsx rax, al   ; fix: the lodsb took 3 bytes -> use al
    
    _should_muliply:
    ; multiply the times rcx is above 0
    cmp rcx, 0
    je _next_digit

    push rcx
    
    _multiply:
    imul rax, 10
    dec rcx
    cmp rcx, 0
    jg _multiply
    pop rcx

    _next_digit:
    add rbx, rax
    inc rcx
    jmp convert_decimal

    _return:
    mov rax, rbx
    cld
    ret

; input rdi - null terminated string pointer to text calculation eg. 1+1
calculate_string:
    xor rax, rax ; used with lodsb
    xor rbx, rbx ; sum output
    xor rsi, rsi ; lods read from rsi

    call str_length
    mov r8, rax
    
    mov rsi, rdi
    add rsi, r8
    dec rsi
    std          ; set direction flag

    mov rcx, 0    ; loop i
    
    load_byte:
    lodsb         ; load a byte into rax
    inc rcx
    
    check_byte:
    ; if rax >= 0x30 (ascii digit)
    cmp rax, 0x30
    jge rax_digit
    
    rax_delimiter:
    mov rcx, 0      ; zero out 10s place
    cmp rax, '-'
    jne positive_number

    negative_number:
    neg rbx

    positive_number:
    jmp load_byte

    rax_digit:
    sub rax, 0x30 ; convert to digit

    ; if rcx > 1 multiply else add_rax
    cmp rcx, 1
    je add_rax
    
    push rcx
    multiply:
    ; if 10s place is more then 1 multiply
    imul rax, 10
    dec rcx
    cmp rcx, 1
    jg multiply
    pop rcx

    add_rax:
    add rbx, rax
    xor rax, rax
    
    ; if byte pointer is less then input string pointer return
    compare_pointers:
    cmp rsi, rdi
    jge load_byte

    return:
    mov rax, rbx
    cld
    ret

; input string rdi
; str_length:
;     mov     rcx, -1
    
;     count_char:
;     inc     rcx
;     mov     al, [rdi + rcx]  ; Load the byte at rsi + rcx
;     cmp     al, 0x00         ; Check if it's the null terminator
;     jne     count_char       ; if only null digits are 0
;     mov     rax, rcx
;     ret

; ------------------