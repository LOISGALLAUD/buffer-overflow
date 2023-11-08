#include <stdlib.h>
#include <unistd.h>

char shellCode[] = "\xb8\x01\x00\x00\x00" //          mov    $0x1,%eax
                   "\xbb\x20\x00\x00\x00" //          mov    $0x20,%ebx
                   "\xcd\x80";            //          int $0x80

int main()
{
    int *ret;
    ret = (int *)&ret + 2;
    *ret = (int)shellCode;
    return 5;
}
