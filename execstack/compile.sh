#!/bin/sh

gcc -mpreferred-stack-boundary=2 -z execstack -o testShellCode testShellCode.c
