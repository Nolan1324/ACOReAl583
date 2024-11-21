#!/bin/bash

set -e

clang -emit-llvm -c test.c -Xclang -disable-O0-optnone -o test.bc
opt test.bc -o test.opt.bc > /dev/null
llc -regalloc=aco < test.opt.bc > test.llc.bc
clang -no-pie -x assembler test.llc.bc -o test.out
./test.out
