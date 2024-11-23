cd ../../build

# cmake -DLLVM_ENABLE_PROJECTS="clang;compiler-rt" -DCMAKE_BUILD_TYPE=Debug -DLLVM_USE_LINKER=lld -S ../llvm -G "Unix Makefiles"
sudo make install -j$(sysctl -n hw.physicalcpu)