#!/bin/bash

set -e

#clang -emit-llvm -S test/universal/test.c -Xclang -disable-O0-optnone -o test.bc
/usr/local/bin/clang -emit-llvm -S test/universal/spill3.c -Xclang -disable-O0-optnone -o spill3.bc
#opt test.bc -o test.opt.bc > /dev/null

#/usr/local/bin/llc -debug-only=regalloc -regalloc=aco test.bc -o test.asm
#/usr/local/bin/llc -debug-only=regalloc -regalloc=aco test/arm/ir/spill-fold.ll -o test.asm
/usr/local/bin/llc -debug-only=regalloc -regalloc=aco spill3.bc -o spill3.asm

/usr/local/bin/clang -x assembler spill3.asm -o spill3.out

#./test.out