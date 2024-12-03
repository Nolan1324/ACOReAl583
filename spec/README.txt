This folder contains a config file to run with spec.

Search for the string "!!!" in the config to find the lines you might need to change.

```
/bin/runcpu --config=config.cfg --action=build 505.mcf_r
/usr/local/bin/clang -m64 -c -o mcfutil.o -DSPEC -DNDEBUG  -Ispec_qsort -DSPEC_AUTO_SUPPRESS_OPENMP  -O3 -mavx -mllvm -regalloc=aco -mllvm -aco-max-time=0.1 -mllvm -aco-num-ants=3              -DSPEC_LP64  mcfutil.c

```