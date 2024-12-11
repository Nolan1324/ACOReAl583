#include <stdio.h>

int main()
{
      FILE *null_file = freopen("/dev/null", "w", stdout); //trash output
    for(int i = 0; i < 19999999; i++) { //change i limit to change benchmark runtime
        /* must not affect how #pragma ppop_macro works */
        #define pop_macro foobar1

        /* must not affect how #pragma push_macro works */
        #define push_macro foobar2

        #undef abort
        #define abort "111"
        printf("abort = %s\n", abort);

        #pragma push_macro("abort")
        #undef abort
        #define abort "222"
        printf("abort = %s\n", abort);

        #pragma push_macro("abort")
        #undef abort
        #define abort "333"
        printf("abort = %s\n", abort);

        #pragma pop_macro("abort")
        printf("abort = %s\n", abort);

        #pragma pop_macro("abort")
        printf("abort = %s\n", abort);
    }
    freopen("/dev/tty", "w", stdout); //this is so it still gives output without creating a huge file
    /* must not affect how #pragma ppop_macro works */
    #define pop_macro foobar1

    /* must not affect how #pragma push_macro works */
    #define push_macro foobar2

    #undef abort
    #define abort "111"
    printf("abort = %s\n", abort);

    #pragma push_macro("abort")
    #undef abort
    #define abort "222"
    printf("abort = %s\n", abort);

    #pragma push_macro("abort")
    #undef abort
    #define abort "333"
    printf("abort = %s\n", abort);

    #pragma pop_macro("abort")
    printf("abort = %s\n", abort);

    #pragma pop_macro("abort")
    printf("abort = %s\n", abort);
}

//Source: https://github.com/c-testsuite/c-testsuite/blob/master/tests/single-exec/00206.c