# Makefile for compiling, running, and cleaning ACOGraphColoring.cpp

TARGET = ACOGraphColoring
SRC = ACOGraphColoringTests.cpp ../ACOGraphColoring.cpp
CXX = g++
CXXFLAGS = -O3 -ffast-math -Wall -g -fopenmp

.PHONY: all clean

all:
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SRC) -I..
	./$(TARGET)
	rm -f $(TARGET)