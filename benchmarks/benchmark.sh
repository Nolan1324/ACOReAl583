#!/bin/bash

# list of tests to compile
TESTS=(
    "00219.c" #source: https://github.com/c-testsuite/c-testsuite/blob/master/tests/single-exec/00219.c
    "00220.c" #source: https://github.com/c-testsuite/c-testsuite/blob/master/tests/single-exec/00220.c
    "00216.c" #source: https://github.com/c-testsuite/c-testsuite/blob/master/tests/single-exec/00216.c
    "00215.c" #source: https://github.com/c-testsuite/c-testsuite/blob/master/tests/single-exec/00215.c
    "00207.c" #source: https://github.com/c-testsuite/c-testsuite/blob/master/tests/single-exec/00207.c
    "00206.c" #source: https://github.com/c-testsuite/c-testsuite/blob/master/tests/single-exec/00206.c
    "00205.c" #source: https://github.com/c-testsuite/c-testsuite/blob/master/tests/single-exec/00205.c
    "00204.c" #source: https://github.com/c-testsuite/c-testsuite/blob/master/tests/single-exec/00204.c
)

#setup
COMPILER="clang"
FLAGS="-O3 -Rpass=register-allocation -Rpass-analysis -fno-inline -lm"
REG_ALLOC="-mllvm -regalloc=basic" #set register allocator
OUTPUT_FILE="output.txt"
echo "Report:" > "$OUTPUT_FILE" 


# compile loop
for SOURCE in "${TESTS[@]}"; do
    START_TIME=$(date +%s)
    $COMPILER $FLAGS $REG_ALLOC "$SOURCE" -o a.out 2> compile.log
    END_TIME=$(date +%s)
    COMPILE_TIME=$((END_TIME - START_TIME))
    SPILL_COUNT=$(grep -i "Type: Spill" compile.log | wc -l)

    #runtime
    { time ./a.out; } > runtime.log 2>&1
    RUNTIME=$(grep real runtime.log | awk '{print $2}' | sed 's/s//')
    echo "$SOURCE: $SPILL_COUNT spills, Compile time: ${COMPILE_TIME}s, Runtime: ${RUNTIME}s" >> "$OUTPUT_FILE"
done

echo "Compilation completed. Results saved to $OUTPUT_FILE."
# rm -f compile.log