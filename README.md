# x86Calc - a CLI calculator

This project is for learning to build in assembly. Took a lot of TDD to make this work. One of the greatest challenges was to parse the math expressions.

## Example

```shell
    #To initialize the project scripts run:
    source ./init.sh


    #you can run test command or ./scripts/test.sh

┌──(kali㉿kali)-[~/rax/x86-assembly]
└─$ test
-------MAIN---------
#exit code test
./output/x86Calc res=1 exp=1 
./output/x86Calc 11 res=1 exp=1 

# math tests
6/3 res=2 exp=2 
1+1 res=2 exp=2 
1+2 res=3 exp=3 
13+6 res=19 exp=19 
1000+0 res=1000 exp=1000 
1-1 res=0 exp=0 
3-1 res=2 exp=2 
10-1 res=9 exp=9 
1-10 res=-9 exp=-9 
10-15 res=-5 exp=-5 
1*2 res=2 exp=2 
9*11 res=99 exp=99 
123456*100 res=12345600 exp=12345600 
0*100 res=0 exp=0 
10/2 res=5 exp=5 
100/5 res=20 exp=20 
100/3 res=33 exp=33 
99/11 res=9 exp=9 
--------------------------
20/20 passed

# Library tests
------STRINGS-------
1, span_equals_PtrPtrChar_1 - expected: 1 result: 1 
2, span_equals_PtrPtrShort_1 - expected: 1 result: 1 
3, span_equals_PtrPtrShort_0 - expected: 0 result: 0 
4, span_equals_PtrPtrInt_1 - expected: 1 result: 1 
5, span_equals_PtrPtrInt_0 - expected: 0 result: 0 
6, span_equals_PtrPtrLong_1 - expected: 1 result: 1 
7, span_equals_PtrPtrLong_0 - expected: 0 result: 0 

8, str_equals_HelloHello_1 - expected: 1 result: 1 
9, str_equals_HelloHalla_0 - expected: 0 result: 0 
10, str_equals_HelloMr_0 - expected: 0 result: 0 

11, str_contains__t_t__1 - expected: 1 result: 1 
12, str_contains__a_t__0 - expected: 0 result: 0 
13, str_contains__ba_b__1 - expected: 1 result: 1 
14, str_contains__abc_b__1 - expected: 1 result: 1 
15, str_contains__abc_d__0 - expected: 0 result: 0 
16, str_contains__abc_bd__0 - expected: 0 result: 0 
17, str_contains__ab_abd__0 - expected: 0 result: 0 
18, str_contains__ab_null__0 - expected: 0 result: 0 
19, str_contains__superlong_99__1 - expected: 1 result: 1 

20, str_len__hello__5 - expected: 5 result: 5 
21, str_len__empty__0 - expected: 0 result: 0 

22, convert_number_to_string__1_2__1null - expected: 1 result: 1 
23, convert_number_to_string__1__not_equal_2 - expected: not 2 result: 1 
24, convert_number_to_string__9__equal - expected: 9 result: 9 
25, convert_number_to_string__9__equal - expected: 69 result: 69 
26, convert_number_to_string__123456789__equal - expected: 123456789 result: 123456789 
27, convert_number_to_string__0__equal - expected: 0 result: 0 
28, convert_number_to_string__neg1__equal - expected: (null) result: (null) 
29, convert_number_to_string__neg1__equal - expected: -1 result: -1 
30, convert_number_to_string__1__len1 - expected: 1 result: 1 
---------------------------------------

30/30 tests passed!

------CALCULATE-----
1, calculate_string__1_plus_1__2 - expected: 2 result: 2 
2, calculate_string__1_plus_2__3 - expected: 3 result: 3 
3, calculate_string__1_plus_0__1 - expected: 1 result: 1 
4, calculate_string__0_plus_1__1 - expected: 1 result: 1 
5, calculate_string__12_plus_2__14 - expected: 14 result: 14 
6, calculate_string__13_plus_21__34 - expected: 34 result: 34 
7, calculate_string__10_plus_1__11 - expected: 11 result: 11 
8, calculate_string__200_plus_1__201 - expected: 201 result: 201 
9, calculate_string__0_plus_1000__1000 - expected: 1000 result: 1000 
10, calculate_string__2_minus_1__1 - expected: 1 result: 1 
11, calculate_string__2_minus_3__neg1 - expected: -1 result: -1 
12, calculate_string__2_minus_10__neg8 - expected: -8 result: -8 
13, calculate_string__1000_minus_1__999 - expected: 999 result: 999 
14, calculate_string__3_times_2__6 - expected: 6 result: 6 
15, calculate_string__10_div_2__5 - expected: 5 result: 5 

16, get_decimal_from_expression__1plus2_2__2 - expected: 2 result: 2 
17, get_decimal_from_expression__2plus30_1__30 - expected: 30 result: 30 
18, get_decimal_from_expression__13plus30_0__13 - expected: 13 result: 13 
19, get_decimal_from_expression__21000minus3220_0__21000 - expected: 21000 result: 21000 
20, get_decimal_from_expression__0plus1000_1__1000 - expected: 1000 result: 1000 

21, get_decimal_with_offset__2plus30_2_3__30 - expected: 30 result: 30 
22, get_decimal_with_offset__2plus243_2_4__243 - expected: 243 result: 243 
23, get_decimal_with_offset__98plus3_0_1__101 - expected: 98 result: 98 
24, get_decimal_with_offset__21000plus3220_0_4__21000 - expected: 21000 result: 21000 
25, get_decimal_with_offset__0plus1000_2_5__1000 - expected: 1000 result: 1000 

---------------------------------------

25/25 tests passed!

-------RESULT-------
PASSED

```

## Setup

- OS: Linux (I use Kali VM)
- x86_64 CPU Architecture
- nasm assembler
- Debugger gdb
- gef - gdb python plugin for better UI
- Bash and C for Unit Tests
- gcc for building C
- Bash for build and run
- VS Code
- VS Code extensions
    - x86 and x86_64 Assembly
    - C/C++
    - Excel viewer
    - Hex Editor

```shell
    # Check your architecture
    uname -m #should return x86_64 CPU Architecture
```

## Init

```shell
    #To initialize the project scripts run:
    source ./init.sh
```

## References

I have a lot of documentation in this repo to be able to keep track of all the assembly consraints and methods. They are in the /ref folder. The refs that does not fit in any document in the folder are documented in this readme.

- [x86_64 intel manual](https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-instruction-set-reference-manual-325383.pdf) saved in ref

- https://treeniks.github.io/x86-64-simplified/

- [ELF x86-64-ABI psABI](https://gitlab.com/x86-psABIs/x86-64-ABI)

- linux syscalls: cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h

- [Syscalls table](https://filippo.io/linux-syscall-table/)

## Assembler

nasm (netwide assembler): open source assembler and disassembler for x86 and x86-64 architectures with its own syntax (compare with masm microsoft macro assembler)

```shell

sudo apt update
sudo apt install nasm -y

```

### Debugger

GDB - gnu debugger

```shell

#https://www.sourceware.org/gdb/
#Gnu debugger

sudo apt-get update
sudo apt-get install gdb

#GEF https://github.com/hugsy/gef
# plugin for gnu -> CLI UI

wget -O ~/.gdbinit-gef.py -q https://gef.blah.cat/py
echo source ~/.gdbinit-gef.py >> ~/.gdbinit

```

### Using the debugger


```shell

b _start
b *_start+6
b *_start+9 if $rbx > 10
b *_cs if $rdi = "0+1000"

disas <label> #gives address of the label
b *0x40100a

delete 1 # delete breakpoint
info breakpoints

r #run
c #continue
kill
si #si - single stepping, si 3 three steps
s # runs to next function
next #n step over


#examine x
x/4ig $rip

#x - examine
#4 - count we want to examine
#i - format (instruction)
#g - giant 8 bytes

x/s 0x402000
# "Hello HTB Academy!"

x/wx 0x401000
#gives little endian

help patch

patch string 0x402000 "123456789\\x0a" 
set $rdx=0x0a

#### other

info functions


```

### Doing a memory dump

```shell
    ps aux | grep print-args
    cd /proc/102040 # get pid
    pmap XX <pid> # print all that the kernel provides

    getconf PAGESIZE # Get memory page size -> 4096 bytes  

```

### Stack tips and input args

- The stack needs to be aligned with 16byte - in other words the address needs to end at 0 not 8. 0x00007fffffffde80

- The stack holds the input arguments and the environment arguments:
    - number of input arguments
    - first argument ptr to string
    - null stack frame 2 bytes  after
    - environment variables

## Returning value and calling conventions

Linux x86_64 uses the System V ABI (application binary interface), this is important to follow so that the code is interopable with C. In eg in this project do we use C to run unit tests. For example compared to Windows where you put all the arguments on the stack, in System V you put them in the registers.

/ref/abi-reg-system-calls.csv
