#include <stdio.h>

extern int printf(const char *format, ...);
static void kb_wait_1(void)
{
    unsigned long timeout = 2;
    do {
        if (1) printf("timeout=%ld\n", timeout);
        else
        {
            while (1)
                printf("error\n");
        }
        timeout--;
    } while (timeout);
}
static void kb_wait_2(void)
{
    unsigned long timeout = 2;
    do {
        if (1) printf("timeout=%ld\n", timeout);
        else
        {
            for (;;)
                printf("error\n");
        }
        timeout--;
    } while (timeout);
}
static void kb_wait_2_1(void)
{
    unsigned long timeout = 2;
    do {
        if (1) printf("timeout=%ld\n", timeout);
        else
        {
            do {
                printf("error\n");
            } while (1);
        }
        timeout--;
    } while (timeout);
}
static void kb_wait_2_2(void)
{
    unsigned long timeout = 2;
    do {
        if (1) printf("timeout=%ld\n", timeout);
        else
        {
            label:
                printf("error\n");
            goto label;
        }
        timeout--;
    } while (timeout);
}
static void kb_wait_3(void)
{
    unsigned long timeout = 2;
    do {
        if (1) printf("timeout=%ld\n", timeout);
        else
        {
            int i = 1;
            goto label;
            i = i + 2;
        label:
            i = i + 3;
        }
        timeout--;
    } while (timeout);
}
static void kb_wait_4(void)
{
    unsigned long timeout = 2;
    do {
	if (1) printf("timeout=%ld\n", timeout);
        else
        {
            switch(timeout) {
                case 2:
                    printf("timeout is 2");
                    break;
                case 1:
                    printf("timeout is 1");
                    break;
                default:
                    printf("timeout is 0?");
                    break;
            };
            /* return; */
        }
        timeout--;
    } while (timeout);
}
int main()
{
    FILE *null_file = freopen("/dev/null", "w", stdout); //trash output (this benchmark creates more than 1gb of data otherwise)
    printf("begin\n");
    kb_wait_1();
    kb_wait_2();
    kb_wait_2_1();
    kb_wait_2_2();
    kb_wait_3();
    kb_wait_4();
    printf("end\n");
    for(int i = 0; i < 19999999; i++) { //change i for benchmark runtime
        kb_wait_1();
        kb_wait_2();
        kb_wait_2_1();
        kb_wait_2_2();
        kb_wait_3();
        kb_wait_4();
    }
    freopen("/dev/tty", "w", stdout); //this is so it still gives output without creating a huge file
    kb_wait_1();
    kb_wait_2();
    kb_wait_2_1();
    kb_wait_2_2();
    kb_wait_3();
    kb_wait_4();
    // return 0;

}

//Source: https://github.com/c-testsuite/c-testsuite/blob/master/tests/single-exec/00215.c