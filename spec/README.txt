This folder contains a config file to run with spec.

Search for the string "!!!" in the config to find the lines you might need to change.

If you get errors about numactl, remove the following lines from the `config.cfg`

```
bind0	= numactl -m 0 --physcpubind=0
bind1	= numactl -m 0 --physcpubind=1
bind2	= numactl -m 0 --physcpubind=2
bind3	= numactl -m 0 --physcpubind=3
bind4	= numactl -m 0 --physcpubind=4
bind5	= numactl -m 0 --physcpubind=5
bind6	= numactl -m 0 --physcpubind=6
bind7	= numactl -m 0 --physcpubind=7
```

Build with

```
/bin/runcpu --config=config.cfg --action=build 505.mcf_r
```

Run the full stack and get a report with

```
/bin/runcpu --config=config.cfg --action=build 505.mcf_r
```

Extra commands for debugging:

```
/usr/local/bin/clang -m64 -c -o mcfutil.o -DSPEC -DNDEBUG  -Ispec_qsort -DSPEC_AUTO_SUPPRESS_OPENMP  -O3 -mavx -mllvm -regalloc=aco -mllvm -aco-max-time=0.1 -mllvm -aco-num-ants=3              -DSPEC_LP64  mcfutil.c
clang -emit-llvm -m64 -c -o mcfutil.bc -DSPEC -DNDEBUG  -Ispec_qsort -DSPEC_AUTO_SUPPRESS_OPENMP  -O3 -mavx -DSPEC_LP64  mcfutil.c -Xclang -disable-O0-optnone
llc -debug-only=regalloc -regalloc=aco mcfutil.bc -o mcfutil.asm 2> out.txt
```