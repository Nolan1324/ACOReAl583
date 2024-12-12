# Define the compiler and flags
CXX = g++
CXXFLAGS = -std=c++17 -Wall -I../

# Define source and output files
SRC = ../ACOGraphColoring.cpp ACOGraphColoringTests.cpp
OBJ = $(SRC:.cpp=.o)
EXEC = ACOGraphColoringTests

# Rule to create the executable
$(EXEC): $(OBJ)
	$(CXX) $(CXXFLAGS) -o $(EXEC) $(OBJ)

# Rule to compile .cpp files to .o object files
%.o: %.cpp ../ACOGraphColoring.h
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean rule to remove object files and the executable
clean:
	rm -f $(OBJ) $(EXEC)

# Run tests after compilation
run: $(EXEC)
	./$(EXEC)

# Default target (run tests after compilation)
all: $(EXEC)
	./$(EXEC)