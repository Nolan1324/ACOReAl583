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
    "dfs_graph_traversal.c" #source: https://www.geeksforgeeks.org/c-program-for-depth-first-search-or-dfs-for-a-graph/
    "pascals_triangle.cpp" #source: https://www.geeksforgeeks.org/pascal-triangle/
    "palindromic_substring_count.cpp" #Source: https://www.geeksforgeeks.org/count-palindrome-sub-strings-string/
    "painter_partition.cpp"  #Source: https://www.geeksforgeeks.org/painters-partition-problem/
    "matrix_chain_multiplication.cpp" #source: https://www.geeksforgeeks.org/matrix-chain-multiplication-dp-8/s
    "bitmasking.cpp" #source: https://www.geeksforgeeks.org/bitmasking-dynamic-programming-set-2-tsp/
    "digit_dp.cpp" #source: https://www.geeksforgeeks.org/digit-dp-introduction/
    "unique_hats.cpp" #source: https://www.geeksforgeeks.org/bitmasking-and-dynamic-programming-set-1-count-ways-to-assign-unique-cap-to-every-person/
    "max_tree_height.cpp" #source: https://www.geeksforgeeks.org/maximum-height-of-tree-when-any-node-can-be-considered-as-root/
    "maximum_sum_rectangle.cpp" #source: https://www.geeksforgeeks.org/maximum-sum-rectangle-in-a-2d-matrix-dp-27/
    "game_strategy.cpp" #source: https://www.geeksforgeeks.org/optimal-strategy-for-a-game-dp-31/
    "n_queens.cpp" #source: https://www.geeksforgeeks.org/printing-solutions-n-queen-problem/
    "ordered_power_set.cpp" #source: https://www.geeksforgeeks.org/powet-set-lexicographic-order/
    "greedy_string_order.cpp" #source: https://www.geeksforgeeks.org/rearrange-a-string-so-that-all-same-characters-become-at-least-d-distance-away/
    "largest_cube.cpp" #source: https://www.geeksforgeeks.org/find-largest-cube-formed-deleting-minimum-digits-number/
    # "new.cpp" #testing

)

#setup
COMPILER="clang++"
FLAGS="-O3 -Rpass=register-allocation -Rpass-analysis -fno-inline -lm -g"
REG_ALLOC="-mllvm -regalloc=greedy" #set register allocator
OUTPUT_FILE="output.txt"
echo "Report:" > "$OUTPUT_FILE" 


# compile loop
for SOURCE in "${TESTS[@]}"; do
    EXT="${SOURCE##*.}"
    if [[ "$EXT" == "c" ]]; then
        COMPILER="clang"
    elif [[ "$EXT" == "cpp" ]]; then
        COMPILER="clang++"
    fi
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

echo "Run completed. Results saved to $OUTPUT_FILE."
# rm -f compile.log