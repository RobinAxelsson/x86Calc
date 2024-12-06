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
    call index_delimiter
    mov rbx, rax

    ; rdi is pointer to expression
    call index_last_digit
    mov rcx, rax

    pop rsi
    cmp rsi, 0
    je first_decimal

    second_decimal:
    inc rbx      ; +1 to get first after delimiter index
    mov rsi, rbx ; get start of second decimal
    mov rdx, rcx ; get end of second decimal

    jmp ret_gdfm

    first_decimal:
    mov rsi, 0   ; get start of first decimal
    dec rbx
    mov rdx, rbx ; get end of first decimal

    ret_gdfm:
    ;rdi pointer
    ;rsi offset start
    ;rdx offset end
    call get_decimal_with_offset
    ret

; input rdi pointer
index_delimiter:
    mov rcx, -1
    mov rsi, rdi
    load_next_char:
    lodsb   ; get char into rax
    inc rcx

    ; if rax != digit return
    cmp al, 0x30
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
    jl return_gdwo

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

    return_gdwo:
    mov rax, rbx
    cld
    ret

; input rdi - null terminated string pointer to text calculation eg. 1+1
calculate_string:
_cs:
    xor rax, rax ; used with lodsb
    xor rsi, rsi ; lods read from rsi
    ; rdi is always pointer to expression in all functions below

    ; calculate the first number, index 0
    ; rdi is pointer to expression
    ; rsi is the number index eg 10+22, 10 rsi=0, 22 rsi=1 
    
    get_decimal_0:
    mov rsi, 0
    call get_decimal_from_expression
    push rax

    get_decimal_1:
    mov rsi, 1
    call get_decimal_from_expression
    push rax

    check_delimiter:
    call index_delimiter
    
    cmp byte [rdi+rax], '+'
    je _addition

    cmp byte [rdi+rax], '-'
    je _subtraction

    _addition:
    pop rbx ; second digit
    pop rax ; first digit
    add rax, rbx
    jmp return_cs

    _subtraction:
    pop rbx ; second digit
    pop rax ; first digit
    sub rax, rbx

    return_cs:
    ret