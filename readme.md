<!--markdownlint-disable MD033-->

# Buffer Overflow Attack

## Context

When program is runned by the OS, it is loaded into memory. The memory is divided into 4 segments:

- Code segment: contains the executable code
- Data segment: contains the global variables
- Heap segment: contains the dynamically allocated memory
- Stack segment: contains the local variables and the return address of the function

The stack is a LIFO data structure(Last In First Out). It is used to store the local variables and the **the return address of the function**. When a function is called, are pushed onto the stack (in order):

- local variables
- return address of the function called (the address of the next instruction to be executed after the function returns)
- Base pointer (BP)

When the function returns, the local variables are popped from the stack. The return address of the function is also pushed onto the stack. When the function returns, the return address is popped from the stack and the program **jumps to that address**.

<img src="./image/readme/ram-illustration.png" alt="ram-illustration" width="500"/>

If we could overwrite the return address of the function, we could make the program jump to a malicious code. This is called a **buffer overflow attack**.

## Vulnerable code

```c
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
    char buffer[500];
    strcpy(buffer, argv[1]);
    return 0;
}
```

As we can see, the program takes an argument and copies it into a buffer of 500 bytes. If the argument is longer than 500 bytes, the buffer will overflow and overwrite the return address of the function.

> How can it overwrite the return address fo the function if the allocation grows from the bottom to the top of the stack (= higher address to lower address) ?
**Because when something is allocated in the RAM, it is growing from the bottom to the top of the stack !** That means that we will be able to overwrite the return address.

## Exploit

Let's first compile the code. For this you can use `make` in the root directory of the project. It will create a `main` executable.

If we executble a terminal `./main Hello`, under the hood, the OS will create a stack like this:

<img src="./image/readme/buffatk-ill.png" alt="stack-illustration" width="500"/>

To see more in depth what's the stack looks like, we can use `gdb`:

```bash
gdb main
```

Then we can use the `disassemble` command to see the assembly code of the `main` function:

```bash
(gdb) disas main
```

### Overflow the buffer

Let's first try to overflow the buffer with a simple string:

```bash
./main $(python -c 'print("\x41" * 505)')

*** stack smashing detected ***: terminated
zsh: IOT instruction (core dumped)  ./main $(python -c 'print("\x41" * 505)')

```

![1699352151682](image/readme/1699352151682.png)

The buffer is overflowed and the program crashed.
