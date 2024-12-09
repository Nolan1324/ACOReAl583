// this file contains BMP chars encoded in UTF-8
#include <stdio.h>
#include <wchar.h>

int main()
{
    wchar_t s[] = L"hello$$你好¢¢世界€€world";
    wchar_t *p;
    for (p = s; *p; p++) printf("%04X ", (unsigned) *p);
    printf("\n");
    // return 0;
    for(int i = 0; i < 4000000; i++) { //change i to change benchmark runtime
        wchar_t s[] = L"hello$$你好¢¢世界€€world";
        wchar_t *p;
        for (p = s; *p; p++) printf("%04X ", (unsigned) *p);
        printf("\n");
    }
}

// File Source: https://github.com/c-testsuite/c-testsuite/blob/master/tests/single-exec/00220.c