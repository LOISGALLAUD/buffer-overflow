#!/bin/sh

gcc -static -ggdb -fno-stack-protector shellcode.c -o shellcode
