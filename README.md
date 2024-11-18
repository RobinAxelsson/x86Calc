# x86_64 assembly and nasm

## Prerequisites

OS: Linux Debian (I use Kali)

```shell
    # CPU Architecture x86_64
    uname -m #returns x86_64
```

## References

- [x86_64 intel manual](https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-instruction-set-reference-manual-325383.pdf) saved in ref

- https://treeniks.github.io/x86-64-simplified/


- linux syscalls: cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h

```shell

# to search in pdf manual? WIP
sudo apt update && sudo apt install poppler-utils
pdftotext ./ref/325383-sdm-vol-2abcd.pdf - | grep "Keyword"

```

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