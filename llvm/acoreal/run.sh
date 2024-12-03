#!/bin/bash

set -e

clang -emit-llvm -S test/universal/test.c -Xclang -disable-O0-optnone -o test.bc
#clang++ -emit-llvm -S test/universal/spill.cpp -Xclang -disable-O0-optnone -o test.bc
#opt test.bc -o test.opt.bc > /dev/null

/usr/local/bin/llc -debug-only=regalloc -regalloc=aco test.bc -o test.asm
#/usr/local/bin/llc -debug-only=regalloc -regalloc=aco test/arm/ir/spill-fold.ll -o test.asm
#/usr/local/bin/llc -debug-only=regalloc -regalloc=aco -aco-max-tabucol-cycles=1 test.bc -o test.asm

clang++ -x assembler test.asm -o test.out

#./test.out