#include <iostream>
#include <vector>
#include <cmath>
#include <limits>
#include <chrono>
#include "math.h"
#include <random>


using namespace std;
using Graph = vector<vector<bool>>; // Adjacency matrix representation

struct Solution {
    vector<int> vertexColors; // Color assignments for vertices
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

void printSolution(const Solution& solution) {
    cout << "Vertex colors: ";
    for (int color : solution.vertexColors) {
        cout << color << " ";
    }
    cout << endl;
    cout << "Conflicting edges: " << solution.conflictingEdges << endl;
    cout << "Conflicting vertices: " << solution.conflictingVertices << endl << endl;
}

struct Parameters {
    double alpha;
    double beta;
    double rho;
    double maxTime;
    int numVertices;
    int numColors;
    int maxCycles;
    int numAnts;
    int gap; // Paper suggests sqrt(maxCycles)
};


void antFixedK(Solution& solution, const Graph& graph, Parameters& params, const std::vector<std::vector<double>>& pheromones);
void reactTabucol(Solution& solution);
void updatePheromones(const Graph& graph, std::vector<std::vector<double>>& pheromones, Parameters& params, const Solution& colonyBest, const Solution& antBest, int cycle, int& pheroCounter) {
    // udpdate pheromone scheme 3
    if (cycle % params.gap == 0) {
        pheroCounter = cycle / params.gap;
    }

    for (int u = 0; u < params.numVertices; ++u) {
        for (int v = 0; v < params.numVertices; ++v) { // TODO: investigate start at v=u?
            // pheromone decay
            pheromones[u][v] *= params.rho;
            
            Solution updatingSolution = pheroCounter > 0 ? colonyBest : antBest;
            if (graph[u][v]) {
                continue;
            }
            if (updatingSolution.vertexColors[u] == updatingSolution.vertexColors[v]) {
                // paper defines this in equation 5 as using conflicting edges. The repo seems to use conflicting vertices though
                pheromones[u][v] += (updatingSolution.conflictingEdges == 0) ? 1 : 1.0 / updatingSolution.conflictingEdges;
            }
        }
    }
}

void ColorAnt3_RT(Solution& solution, const Graph& graph, Parameters& params) {
    vector<vector<double>> pheromones(params.numVertices, vector<double>(params.numVertices, 1.0));
    
    int bestSolutionValue = numeric_limits<int>::max();
    Solution colonyBest(params.numVertices);
    for (int u = 0; u < params.numVertices; ++u) {
        for (int v = 0; v < params.numVertices; ++v) {
            if (graph[u][v]) {
                pheromones[u][v] = 0; // Set to 0 if an edge exists between u and v
            }
        }
    }
    
    int cycles = 1; // starts at 1 accoridng to repo
    int pheroCounter = 0; // we think it starts at 0 from the repo
    auto duration = std::chrono::duration<double>(params.maxTime); // Run for maxTime seconds
    auto start = std::chrono::steady_clock::now(); // Record the start time

    while (cycles < params.maxCycles && bestSolutionValue > 0 && std::chrono::steady_clock::now() - start < duration) {
        int bestAntValue = numeric_limits<int>::max();
        Solution antBest(params.numVertices);
        for (int ant = 1; ant <= params.numAnts; ++ant) {
            Solution solution(params.numVertices);
            antFixedK(solution, graph, params, pheromones);
            reactTabucol(solution);
            
            if (solution.conflictingEdges == 0 || solution.conflictingEdges < bestAntValue) {
                bestAntValue = solution.conflictingEdges;
                antBest = solution;
                //cout << "TESTING TESTING" << endl;
                // potential optimization
                // bestCycleSolution.vertexColors = move(solution.vertexColors); // Move the vector
                // bestCycleSolution.conflictingEdges = solution.conflictingEdges; // Move the conflictingEdges value
            }
        }
        if (bestAntValue < bestSolutionValue) {
            //printSolution(antBest);
            colonyBest = antBest;
            bestSolutionValue = bestAntValue;
        }

        updatePheromones(graph, pheromones, params, colonyBest, antBest, cycles, pheroCounter);
        --pheroCounter;
        ++cycles;
    }
    solution = colonyBest;
}

// if this is a bottleneck can redo saturation storing
int saturation(const vector<int>& neighborsByColor) {
    int saturationVal = 0;
    for (size_t i = 0; i < neighborsByColor.size(); ++i) {
        if (neighborsByColor[i] > 0) {
            saturationVal += 1;
        }
    }
    return saturationVal;
}

double pheromoneTrail(int vertex, int color, Solution& solution, const vector<vector<double>>& pheromones) {
    double numColored = 0;
    double pheromoneSum = 0;
    for (size_t u = 0; u < solution.vertexColors.size(); ++u) {
        if (solution.vertexColors[u] != color) {
            continue;
        }
        ++numColored;
        pheromoneSum += pheromones[u][vertex];
    }
    if (numColored == 0) {
        return 1.0;
    }
    return pheromoneSum / numColored;
}

double heuristic(int vertex, int color, vector<vector<int>>& neighborsByColor) {
    // Paper doesn't add 1 to denominator, repo does. Without adding one, gets /0 error
    return 1 / (neighborsByColor[vertex][color] + 1);
}

double assignmentWeight(int vertex, int color, Parameters& params, vector<vector<int>>& neighborsByColor, Solution& solution, const vector<vector<double>>& pheromones) {
    return pow(pheromoneTrail(vertex, color, solution, pheromones), params.alpha)
         * pow(heuristic(vertex, color, neighborsByColor), params.beta);
}

int bestColor(int vertex, Parameters& params, vector<vector<int>>& neighborsByColor, Solution& solution, const vector<vector<double>>& pheromones) {
    vector<double> weights;
    weights.reserve(params.numColors);
    for (auto color = 0; color < params.numColors; ++color) {
        weights.push_back(assignmentWeight(vertex, color, params, neighborsByColor, solution, pheromones));
    }

    random_device randomDevice;
    mt19937 gen(randomDevice()); // psuedo-RNG
    discrete_distribution<> dist(weights.begin(), weights.end());
    return dist(gen);
}

void antFixedK(Solution& solution, const Graph& graph, Parameters& params, const std::vector<std::vector<double>>& pheromones) {
    vector<vector<int>> neighborsByColor(params.numVertices, vector<int>(params.numColors, 0)); // store saturation directly here later (n+1)
    
    int numUncolored = params.numVertices;
    while (numUncolored > 0) {
        int highestSaturation = -1;
        int chosenVertex = -1;
        for (int v = 0; v < params.numVertices; ++v) {
            if (solution.vertexColors[v] != -1) {
                continue;
            }

            int sat = saturation(neighborsByColor[v]);
            if (sat > highestSaturation) {
                chosenVertex = v;
                highestSaturation = sat;
            }
        }
        int color = bestColor(chosenVertex, params, neighborsByColor, solution, pheromones);
        solution.vertexColors[chosenVertex] = color;

        for (int u = 0; u < params.numVertices; ++u) {
            if (graph[u][chosenVertex]) {
                ++neighborsByColor[u][color];
                if (solution.vertexColors[u] == color)  {
                    ++solution.conflictingEdges;
                }
            }
        }
        --numUncolored;
    }
}

void reactTabucol(Solution& solution) {
}

void ColorAnt3WithSpilling(Solution& solution, const Graph& graph, Parameters& params) {
    ColorAnt3_RT(solution, graph, params);
    while (true) {
        vector<int> conflictCount(graph.size(), 0);
        for (size_t u = 0; u < graph.size(); ++u) {
            for (size_t v = 0; v < graph[u].size(); ++v) {
                if (graph[u][v] && solution.vertexColors[u] != -1 && solution.vertexColors[u] == solution.vertexColors[v]) {
                    conflictCount[u]++;
                    conflictCount[v]++;
                }
            }
        }

        int maxConflicts = 0;
        int spillNode = -1;
        for (size_t i = 0; i < conflictCount.size(); ++i) {
            if (conflictCount[i] > maxConflicts) {
                maxConflicts = conflictCount[i];
                spillNode = i;
            }
        }

        if (spillNode == -1) {
            break;
        }
        solution.vertexColors[spillNode] = -1;
    }
    
}


int main() {
    // Test Case 1: Simple Bipartite Graph
    Graph graph1 = {
        {0, 1, 1, 0},
        {1, 0, 1, 1},
        {1, 1, 0, 1},
        {0, 1, 1, 0}
    };
    Parameters params1 = {3.0, 16.0, 0.7, 100.0, 4, 2, 625, 80, static_cast<int>(sqrt(625))};
    Solution solution1(4);
    ColorAnt3WithSpilling(solution1, graph1, params1);
    cout << "Test Case 1: Simple Bipartite Graph" << endl;
    printSolution(solution1);

    // Test Case 2: Triangle Graph (K3)
    Graph graph2 = {
        {0, 1, 1},
        {1, 0, 1},
        {1, 1, 0}
    };
    Parameters params2 = {3.0, 16.0, 0.7, 100.0, 3, 2, 625, 80, static_cast<int>(sqrt(625))};
    Solution solution2(3);
    ColorAnt3WithSpilling(solution2, graph2, params2);
    cout << "Test Case 2: Triangle Graph (K3)" << endl;
    printSolution(solution2);

    // Test Case 3: Complete Graph (K5)
    Graph graph3 = {
        {0, 1, 1, 1, 1},
        {1, 0, 1, 1, 1},
        {1, 1, 0, 1, 1},
        {1, 1, 1, 0, 1},
        {1, 1, 1, 1, 0}
    };
    Parameters params3 = {3.0, 16.0, 0.7, 100.0, 5, 4, 625, 80, static_cast<int>(sqrt(625))};
    Solution solution3(5);
    ColorAnt3WithSpilling(solution3, graph3, params3);
    cout << "Test Case 3: Complete Graph (K5)" << endl;
    printSolution(solution3);

    return 0;
}