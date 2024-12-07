#!/bin/bash

set -e

/usr/local/bin/clang++ -emit-llvm -S sort.cpp -Xclang -disable-O0-optnone -isysroot $(xcrun --show-sdk-path) -o sort.bc
/usr/local/bin/llc -debug-only=regalloc -regalloc=aco sort.bc -o sort.asm
/usr/local/bin/clang++ -isysroot $(xcrun --show-sdk-path) -x assembler sort.asm -o sort.out