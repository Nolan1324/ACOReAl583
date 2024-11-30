#include <iostream>
#include <vector>
#include <cmath>
#include <limits>
#include <chrono>
#include "math.h"
#include <random>


// TODO: Register constrains

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
    vector<vector<bool>> allowedColors;
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


void updatePheromones(const Graph& graph, vector<vector<double>>& pheromones, Parameters& params, const Solution& colonyBest, const Solution& antBest, int cycle, int& pheroCounter) {
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

int optimizationFunction(const Solution& solution) {
    return solution.conflictingEdges;
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
    double epsilon = 0.000000001;
    return (pheromoneSum + epsilon) / numColored;
}

double heuristic(int vertex, int color, vector<vector<int>>& neighborsByColor) {
    // Paper doesn't add 1 to denominator, repo does. Without adding one, gets /0 error
    return 1.0 / (neighborsByColor[vertex][color] + 1);
}

double assignmentWeight(int vertex, int color, Parameters& params, vector<vector<int>>& neighborsByColor, Solution& solution, const vector<vector<double>>& pheromones) {
    return pow(pheromoneTrail(vertex, color, solution, pheromones), params.alpha)
         * pow(heuristic(vertex, color, neighborsByColor), params.beta)
         * params.allowedColors[vertex][color];
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
    int selection = dist(gen);
    return selection;
}

void antFixedK(Solution& solution, const Graph& graph, Parameters& params, const vector<vector<double>>& pheromones) {
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

// Count the number of conflicts caused by any given vertex being set to any given color
void countConflicts(vector<vector<int>>& conflicts, const Graph& graph, Solution& solution, Parameters& params) {
    for (int i = 0; i < params.numVertices; i++) {
        for (int j = 0; j < params.numVertices; j++) {
            if (graph[i][j]) {
                conflicts[solution.vertexColors[j]][i]++;
            }
        }
    }
}

class LocalStep {
public:
    int vertex;
    int color;
};

void reactTabucol(Solution& solution, const Graph& graph, Parameters& params) {
    return;
    vector<vector<int>> conflicts(params.numVertices, vector<int>(params.numColors, 0));
    countConflicts(conflicts, graph, solution, params);
    while (true) {
        vector<int> conflictingVertices;
        for (int i = 0; i < params.numVertices; i++) {
            if (conflicts[solution.vertexColors[i]][i] > 0) {
                //total_conflicts += conflicts[solution->color_of[i]][i];
                //nodes_in_conflict[0]++;
                //conf_position[i] = nodes_in_conflict[0];
                conflictingVertices.push_back(i);
            }
        }

        int bestValue = numeric_limits<int>::max();
        for (int i: conflictingVertices) {
            for (int c = 0; c < params.numColors; c++) {
                int newValue = solution.conflictingEdges + conflicts[c][i] - conflicts[solution.vertexColors[i]][i];
                bool localBest = newValue <= bestValue;
                if (localBest && true) { // Fix later

                }
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
            reactTabucol(solution, graph, params);
            
            if (solution.conflictingEdges == 0 || solution.conflictingEdges < bestAntValue) {
                bestAntValue = optimizationFunction(solution);
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


void testCase1() {
    Graph graph1 = {
        {0, 1, 1, 0},
        {1, 0, 1, 1},
        {1, 1, 0, 1},
        {0, 1, 1, 0}
    };
    Graph allAllowed1 = {
        {1, 0},
        {1, 1},
        {1, 1},
        {1, 1}
    };
    Parameters params1 = {allAllowed1, 3.0, 16.0, 0.7, 100.0, 4, 2, 625, 80, static_cast<int>(sqrt(625))};
    Solution solution1(4);
    ColorAnt3WithSpilling(solution1, graph1, params1);
    cout << "Test Case 1: Simple Bipartite Graph" << endl;
    printSolution(solution1);
}

void testCase2() {
    // Test Case 2: Triangle Graph (K3)
    Graph graph2 = {
        {0, 1, 1},
        {1, 0, 1},
        {1, 1, 0}
    };
    Graph allAllowed2 = {
        {1, 0},
        {1, 1},
        {1, 1}
    };
    Parameters params2 = {allAllowed2, 3.0, 16.0, 0.7, 100.0, 3, 2, 625, 80, static_cast<int>(sqrt(625))};
    Solution solution2(3);
    ColorAnt3WithSpilling(solution2, graph2, params2);
    cout << "Test Case 2: Triangle Graph (K3)" << endl;
    printSolution(solution2);
}

void testCase3() {
    // Test Case 3: Complete Graph (K5)
    Graph graph3 = {
        {0, 1, 1, 1, 1},
        {1, 0, 1, 1, 1},
        {1, 1, 0, 1, 1},
        {1, 1, 1, 0, 1},
        {1, 1, 1, 1, 0}
    };
    Graph allAllowed3 = {
        {1, 0, 1, 1},
        {1, 1, 1, 1},
        {1, 1, 1, 1},
        {1, 1, 1, 1},
        {0, 1, 1, 1}
    };
    Parameters params3 = {allAllowed3, 3.0, 16.0, 0.7, 100.0, 5, 4, 625, 80, static_cast<int>(sqrt(625))};
    Solution solution3(5);
    ColorAnt3WithSpilling(solution3, graph3, params3);
    cout << "Test Case 3: Complete Graph (K5)" << endl;
    printSolution(solution3);
}

int main() {
    //testCase1();
    //testCase2();
    testCase3();
    return 0;
}