#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void main()
{
    char *name[2];

    name[0] = "/bin/sh";
    name[1] = NULL;
    execve(name[0], name, NULL);
    printf("Hello, World!\n");
    exit(0);
}
