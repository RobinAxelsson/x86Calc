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

- [ELF x86-64-ABI psABI](https://gitlab.com/x86-psABIs/x86-64-ABI)

- linux syscalls: cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h

```shell

# to search in pdf manual? WIP
sudo apt update && sudo apt install poppler-utils
pdftotext ./ref/325383-sdm-vol-2abcd.pdf - | grep "Keyword"

```

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

    117518:   /home/kali/rax/x86-assembly/output/print-args
     Address Perm   Offset Device   Inode Size KernelPageSize MMUPageSize Rss Pss Pss_Dirty Shared_Clean Shared_Dirty Private_Clean Private_Dirty Referenced Anonymous KSM LazyFree AnonHugePages ShmemPmdMapped FilePmdMapped Shared_Hugetlb Private_Hugetlb Swap SwapPss Locked THPeligible              VmFlags Mapping
    00400000 r--p 00000000  08:02 3408616    4              4           4   4   4         0            0            0             4             0          4         0   0        0             0              0             0              0               0    0       0      0           0       rd mr mw me sd print-args
    00401000 r-xp 00001000  08:02 3408616    4              4           4   4   4         4            0            0             0             4          4         4   0        0             0              0             0              0               0    0       0      0           0    rd ex mr mw me sd print-args
7ffff7ff9000 r--p 00000000  00:00       0   16              4           4   0   0         0            0            0             0             0          0         0   0        0             0              0             0              0               0    0       0      0           0 rd mr pf io de dd sd [vvar]
7ffff7ffd000 r-xp 00000000  00:00       0    8              4           4   8   0         0            8            0             0             0          8         0   0        0             0              0             0              0               0    0       0      0           0 rd ex mr mw me de sd [vdso]
7ffffffde000 rw-p 00000000  00:00       0  132              4           4   8   8         8            0            0             0             8          8         8   0        0             0              0             0              0               0    0       0      0           0 rd wr mr mw me gd ac [stack]
                                          ==== ============== =========== === === ========= ============ ============ ============= ============= ========== ========= === ======== ============= ============== ============= ============== =============== ==== ======= ====== =========== 
                                           164             20          20  24  16        12            8            0             4            12         24        12   0        0             0              0             0              0               0    0       0      0           0 KB 


    getconf PAGESIZE # Get memory page size -> 4096 bytes
    # [vvar] is used for acess read-only kernel data without making a system call eg. CLOCK_REALTIME, CLOCK_MONOTONIC
    # [vdso] is a small shared library provided by the kernel and always mapped into the memory, user space versions of certain system calls for performance reasons. gettimeofday(), clock_gettime(), clock_getres()
    # see csv tables in ref

    


```

### Stack tips

- The stack needs to be aligned with 16byte - in other words the address needs to end at 0 not 8. 0x00007fffffffde80

- The stack holds the input arguments and the environment arguments:
    - number of input arguments
    - first argument ptr to string
    - ...additional
    - null stack frame 2 bytes  after
    - environment variables

0x00007fffffffde80│+0x0000: 0x0000000000000001   ← $rsp
0x00007fffffffde88│+0x0008: 0x00007fffffffe1fd  →  "/home/kali/rax/x86-assembly/output/print-args"
0x00007fffffffde90│+0x0010: 0x0000000000000000
0x00007fffffffde98│+0x0018: 0x00007fffffffe22b  →  "SHELL=/usr/bin/zsh"
0x00007fffffffdea0│+0x0020: 0x00007fffffffe23e  →  "SESSION_MANAGER=local/kali:@/tmp/.ICE-unix/870,uni[...]"
0x00007fffffffdea8│+0x0028: 0x00007fffffffe28a  →  "WINDOWID=0"
0x00007fffffffdeb0│+0x0030: 0x00007fffffffe295  →  "QT_ACCESSIBILITY=1"
0x00007fffffffdeb8│+0x0038: 0x00007fffffffe2a8  →  "COLORTERM=truecolor"
