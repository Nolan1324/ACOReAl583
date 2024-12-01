#pragma once

#include <iostream>
#include <vector>
#include <cmath>
#include <limits>
#include "math.h"

using Graph = std::vector<std::vector<bool>>; // Adjacency matrix representation

struct Solution {
    std::vector<int> vertexColors; // Color assignments for vertices
    int conflictingEdges = 0;
    int conflictingVertices = 0;

    Solution(int numVertices, int initialColor = -1)
        : vertexColors(numVertices, initialColor) {}
    
    Solution(const Solution& other) = default;  // Copy constructor
    Solution& operator=(const Solution& other) = default;  // Copy assignment operator
    Solution(Solution&& other) = default;  // Move constructor
    Solution& operator=(Solution&& other) = default;  // Move assignment operator
    ~Solution() = default;  // Destructor
};

struct Parameters {
    std::vector<std::vector<bool>> allowedColors; // Initialized in the constructor
    double alpha = 3.0;
    double beta = 16.0;
    double rho = 0.7;
    double maxTime = 100.0;
    double maxTabucolTime = 0.1;
    int numVertices; // Required
    int numColors;   // Required
    int maxCycles = 625;
    int maxTabulcolCycles = 25;
    int numAnts = 80;
    int gap = 25; // Paper suggests sqrt(maxCycles)

    // Constructor with required numVertices and numColors
    Parameters(int numVertices, int numColors)
        : numVertices(numVertices), numColors(numColors),
          allowedColors(numVertices, std::vector<bool>(numColors, true)) {} // Matrix of trues
};

void ColorAnt3_RT(Solution& solution, const Graph& graph, Parameters& params);
void ColorAnt3WithSpilling(Solution& solution, const Graph& graph, Parameters& params);
void printSolution(const Solution& solution);