# Makefile

# Directories for benchmarks
BUILD_DIR=build
OS := $(shell uname -s)

build:
	set -e
	@if [ ! -d "$(BUILD_DIR)" ]; then \
		echo "Creating $(BUILD_DIR) directory..."; \
		mkdir -p $(BUILD_DIR); \
	fi
	@cd $(BUILD_DIR) && \
	cmake -DLLVM_ENABLE_PROJECTS="clang;compiler-rt" -DCMAKE_BUILD_TYPE=Release \
		-DLLVM_USE_LINKER=lld -S ../llvm -G "Unix Makefiles" && \
	if [ "$(OS)" = "Darwin" ]; then \
		echo "Detected macOS. Running make install with $$(sysctl -n hw.physicalcpu) jobs..."; \
		sudo make install -j$$(sysctl -n hw.physicalcpu); \
	else \
		echo "Detected Linux. Running make install with $$(nproc) jobs..."; \
		make install -j$$(nproc); \
	fi

llc:
	sudo cmake --build $(BUILD_DIR) --target install-llc -j$(nproc)

run:
	clang -emit-llvm -c test.c -Xclang -disable-O0-optnone -o test.bc
	opt test.bc -o test.opt.bc > /dev/null

# usage: make run-aco | run-greedy | run-basic
run-%: build run
	set -e

	make run
	echo "Using register allocator: $*"
	./build/bin/llc -regalloc=$*  < test.opt.bc > test.llc.$*.bc
	clang -no-pie -x assembler test.llc.$*.bc -o test.$*.out
	./test.$*.out

# Clean up only created files bc build takes forever
clean:
	@echo "Cleaning up created files..."
	rm test.bc test.llc.*.bc test.opt.bc test.*.out

.PHONY: run