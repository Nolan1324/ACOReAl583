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
UNIQUE_ID=$(date +%s.%N)
DIRECTORY_NAME="greedy_run_ $UNIQUE_ID" # change this to not overwrite results of previous run, or use unique id
OUTPUT_FILE="$DIRECTORY_NAME/output.txt"
mkdir "$DIRECTORY_NAME"
echo "Report:" > "$OUTPUT_FILE" 


# compile loop
for SOURCE in "${TESTS[@]}"; do
    EXT="${SOURCE##*.}"
    if [[ "$EXT" == "c" ]]; then
        COMPILER="clang"
    elif [[ "$EXT" == "cpp" ]]; then
        COMPILER="clang++"
    fi
    START_TIME=$(date +%s.%N)
    $COMPILER $FLAGS $REG_ALLOC "$SOURCE" -o "$DIRECTORY_NAME/$SOURCE".out 2> "$DIRECTORY_NAME/$SOURCE"_compile.log
    END_TIME=$(date +%s.%N)
    COMPILE_TIME=$(echo "$END_TIME - $START_TIME" | bc)
    SPILL_COUNT=$(grep -i "Type: Spill" "$DIRECTORY_NAME/$SOURCE"_compile.log | wc -l)

    #runtime
    start_time=$(date +%s.%N)
    { time ./"$DIRECTORY_NAME/$SOURCE".out; } > "$DIRECTORY_NAME/$SOURCE"_runtime.log 2>&1
    end_time=$(date +%s.%N)
    RUN_TIME=$(echo "$end_time - $start_time" | bc)
    echo "$SOURCE: $SPILL_COUNT spills, Compile time: ${COMPILE_TIME}s, Runtime: ${RUN_TIME}s" >> "$OUTPUT_FILE"
    clear # removes random terminal output
done

echo "Run completed. Results saved to $OUTPUT_FILE."
# rm -f compile.log