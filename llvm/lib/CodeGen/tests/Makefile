# Compiler and flags
CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -O2 -I../

# Target and source files
TARGET = ACOGraphColoringTests
SRC = ACOGraphColoringTests.cpp

# Default rule: compile and run
all: $(TARGET)
	./$(TARGET)

# Rule to build the executable
$(TARGET): $(SRC)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SRC)

# Clean rule to remove the executable
clean:
	rm -f $(TARGET)