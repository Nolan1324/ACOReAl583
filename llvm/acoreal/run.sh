#!/bin/bash

set -e

#clang -emit-llvm -S test/universal/test.c -Xclang -disable-O0-optnone -o test.bc
#opt test.bc -o test.opt.bc > /dev/null

#/usr/local/bin/llc -debug-only=regalloc -regalloc=aco test.bc -o test.asm
/usr/local/bin/llc -debug-only=regalloc -regalloc=aco test/arm/ir/spill-reload-remarks.ll -o test.asm

#clang -x assembler test.asm -o test.out

#./test.out