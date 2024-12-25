global format
extern str_length
extern calculate_string
extern get_decimal_from_expression
extern get_decimal_with_offset
extern count_expressions

get_decimal_from_expression:
    ; rdi is pointer to expression
    ; rsi is the number index eg 10+22, 10 rsi=0, 22 rsi=1 
    xor rax, rax
    xor rbx, rbx ; used for delimiter offset
    xor rcx, rcx ; used for end of string

    push rsi
    ; rdi is pointer to expression
    ; rsi is index
    mov rsi, 0
    call index_delimiter
    mov rbx, rax

    ; rdi is pointer to expression
    ; rsi index of delimiter
    mov rsi, 1
    call index_delimiter
    dec rax
    mov rcx, rax

    pop rsi
    cmp rsi, 0
    je first_decimal

    second_decimal:
    inc rbx      ; +1 to get first after delimiter index
    mov rsi, rbx ; get start of second decimal
    mov rdx, rcx ; get end of second decimal

    jmp return_gdfe

    first_decimal:
    mov rsi, 0   ; get start of first decimal
    dec rbx
    mov rdx, rbx ; get end of first decimal

    return_gdfe:
    ;rdi pointer
    ;rsi offset start
    ;rdx offset end
    call get_decimal_with_offset
    ret

count_expressions:
    ; rdi pointer to expression
    xor rcx, rcx
    xor rax, rax

    cmp byte [rdi], 0x0 ; check if empty string, null
    je end_of_string

    load_next:
    lodsb       ; load char into rax
    cmp al, 0x0 ; char is null
    jle end_of_string

    cmp al, 0x30
    jl is_delimiter

    is_digit:
    jmp load_next

    is_delimiter:
    inc rcx
    jmp load_next
    
    end_of_string:
    mov rax, rcx
    ret

; input rdi pointer
; input rsi index
index_delimiter:
    mov r8, rsi ; which number
    mov rcx, -1
    mov rsi, rdi
    load_next_char:
    lodsb   ; get char into rax
    inc rcx

    ; if rax != digit return
    cmp al, 0x30
    jge load_next_char

    is_delmimiter:
    dec r8
    cmp r8, -1
    jg load_next_char

    ; get first char after
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
    xor rax, rax ; used with lodsb
    xor rsi, rsi ; lods read from rsi
    ; rdi is always pointer to expression in all functions below

    mov r8, 2 ; set how many times to iterate
    xor rcx, rcx ; counter

    push_decimals: ; iterates 2 times over the expression  
    cmp rcx, r8
    je check_delimiter

    push rcx
    push r8
    mov rsi, rcx
    ; rdi is pointer to expression
    ; rsi is the number index eg 10+22, 10 rsi=0, 22 rsi=1 
    call get_decimal_from_expression
    pop r8
    pop rcx
    push rax ; push the resulting decimal on the stack
    
    inc rcx
    jmp push_decimals

    check_delimiter:
    ; rsi is index
    ; rdi is char*
    mov rsi, 0
    call index_delimiter
    
    cmp byte [rdi+rax], '+'
    je addition

    cmp byte [rdi+rax], '-'
    je subtraction

    cmp byte [rdi+rax], '*'
    je multiply

    cmp byte [rdi+rax], '/'
    je division

    addition:
    pop rbx ; second digit
    pop rax ; first digit
    add rax, rbx
    jmp return_cs

    subtraction:
    pop rbx ; second digit
    pop rax ; first digit
    sub rax, rbx
    jmp return_cs

    multiply:
    pop rbx ; second digit
    pop rax ; first digit
    imul rax, rbx
    jmp return_cs

    division:
    pop rbx ; second digit
    pop rax ; first digit

    ; division: rax / rcx = rax + reminder rdx ; replace rcx to constant
    xor     rdx, rdx    ; clear rdx, else gives floating point exception
    idiv    rbx         ; rax = quotient, rdx = reminder, needs to be register

    return_cs:
    ret