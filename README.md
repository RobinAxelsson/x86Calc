# x86Calc - a CLI calculator

This project is for learning to build in assembly. Took a lot of TDD to make this work. One of the greatest challenges was to parse the math expressions.

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
