; __DATE__, Current date
db __DATE__

; __TIME__, Current time
db __TIME__

; __FILE__, Current file name of current file being assembled
db __FILE__

; __LINE__, Current line number
db __LINE__

; $$, Start of current section
db $$

; $, Current location in section
db $  

; $, Current location in section
message db "Hello", 0xA
len equ $ - message  ; Length of "Hello\n"

; $$, Start of current section
section .data
start_of_section db "Data here"
len_from_start equ $ - $$ ; Offset from start of section

; %define, Defines constants/macros
%define MSG "Hello"
db MSG

; %assign, Numeric constants
%assign COUNT 10
times COUNT db 0  ; Creates 10 zero bytes

; %if, %else, %endif, Conditional assembly
%if 1
    db "Included"
%else
    db "Excluded"
%endif

; %macro/%endmacro, Reusable macros
%macro add 2
    mov rax, %1
    add rax, %2
%endmacro
add 5, 10  ; Example usage

; %include, Include files
%include "macros.inc"

; __FILE__, Current source file name
db __FILE__

; __LINE__, Current line number
db __LINE__

; %error, Custom error
%if 0
    %error "This should not happen!"
%endif

; %warning, Custom warning
%if 1
    %warning "This is just a test."
%endif

; %rep/%endrep, Repeated code
%rep 5
    db 0  ; 5 zero bytes
%endrep

; %define/%undef, Define/undefine constants
%define VALUE 10
%undef VALUE  ; VALUE is no longer defined

; %xdefine, Redefinable constants
%xdefine VALUE 10
%xdefine VALUE 20

; %arg with nested macros
%macro multiply 2
    mov eax, %1
    imul eax, %2
%endmacro
multiply 6, 7  ; Multiply 6 by 7

; %arg, Macro arguments
%macro add_args 2
    mov eax, %1
    add eax, %2
%endmacro
add_args 3, 7  ; Example usage

; %%, Unique labels in macros
%macro unique_macro 0
    %%label: nop  ; Unique label
%endmacro
unique_macro

; %%, Unique labels
%macro loop_with_unique_label 1
    %%loop:
        dec %1
        jnz %%loop
%endmacro
loop_with_unique_label ecx  ; Loop while ecx != 0

; %ifidn/%ifidni, Compare strings
%ifidn __FILE__, "test.asm"
    db "This is test.asm"
%else
    db "Unknown file"
%endif

; %strlen, Calculate length of string during assembly
%define STR "Assembly"
len equ %strlen STR
db STR, 0  ; Store "Assembly" string

; %substr, Extract substring
%define MYSTRING "ExampleString"
db %substr MYSTRING, 0, 7  ; Outputs "Example"

; %rotate, Rotate value during assembly
%assign VAL 0x1234
%rotate VAL, 4
db VAL  ; Outputs rotated value

; %include with dynamic filenames
%define INCLUDE_FILE "extra.asm"
%include INCLUDE_FILE
