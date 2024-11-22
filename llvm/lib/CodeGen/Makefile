# Makefile for compiling, running, and cleaning ACOGraphColoring.cpp

TARGET = ACOGraphColoring
SRC = ACOGraphColoring.cpp
CXX = g++
CXXFLAGS = -O2 -Wall -g

.PHONY: all clean

all:
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SRC)
	./$(TARGET)
	rm -f $(TARGET)