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
};

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
void reactTabucol(Solution& solution, const Graph& graph, int k, Solution initialSolution);
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
    auto nVertices = graph.size();
    vector<vector<double>> pheromones(nVertices, vector<double>(nVertices, 1.0));
    
    int bestSolutionValue = numeric_limits<int>::infinity();
    Solution colonyBest(params.numVertices);
    for (int u = 0; u < nVertices; ++u) {
        for (int v = 0; v < nVertices; ++v) {
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
        int bestCycleValue = std::numeric_limits<int>::infinity();
        Solution antBest(params.numVertices);
        for (int ant = 1; ant <= params.numAnts; ++ant) {
            Solution solution(params.numVertices);
            antFixedK(solution, graph, params, pheromones);
            // REACT_TABUCOL ... whatever that means...
            if (solution.conflictingEdges == 0 || solution.conflictingEdges < bestSolutionValue) {
                bestCycleValue = solution.conflictingEdges;
                antBest = solution;
                // potential optimization
                // bestCycleSolution.vertexColors = move(solution.vertexColors); // Move the vector
                // bestCycleSolution.conflictingEdges = solution.conflictingEdges; // Move the conflictingEdges value
            }
        }
        if (bestCycleValue < bestSolutionValue) {
            colonyBest = antBest;
            bestSolutionValue = bestCycleValue;
        }

        updatePheromones(graph, pheromones, params, colonyBest, antBest, cycles, pheroCounter);
        --pheroCounter;
        ++cycles;
    }
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
    return 1 / neighborsByColor[vertex][color];
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
        for (size_t v = 0; v < params.numVertices; ++v) {
            if (solution.vertexColors[v] != -1) {
                continue;
            }

            int sat = saturation(neighborsByColor[v]);
            if (sat > highestSaturation) {
                chosenVertex = v;
                highestSaturation = sat;
            }

            int color = bestColor(chosenVertex, params, neighborsByColor, solution, pheromones);
            solution.vertexColors[chosenVertex] = color;

            for (int u = 0; u < params.numVertices; ++u) {
                if (graph[u][v]) {
                    ++neighborsByColor[u][color];
                    if (solution.vertexColors[u] == color)  {
                        ++solution.conflictingEdges;
                    }
                }
            }
            --numUncolored;
        }
    }
}

Solution reactTabucol(const Graph& graph, int k, Solution initialSolution) {
    // Implement reactive tabu search to minimize conflicts in the solution
    Solution optimizedSolution = initialSolution;
    // Pseudocode logic here...
    return optimizedSolution;
}

void updatePheromones(std::vector<std::vector<double>>& pheromones, const Solution& bestSolution, double evaporationRate) {
    // Update pheromone values based on the best solution
    for (int v = 0; v < bestSolution.vertexColors.size(); ++v) {
        int color = bestSolution.vertexColors[v];
        pheromones[v][color] += 1.0 / (bestSolution.conflicts + 1); // Reinforce with conflict-based weight
    }
}


void testColorAnt3RT() {
    // Test Case 1: Triangle Graph
    Graph graph1 = {
        {0, 1, 1},
        {1, 0, 1},
        {1, 1, 0}
    };
    int k1 = 3, maxCycles1 = 50, maxTime1 = 1000, nAnts1 = 5;
    Solution result1 = ColorAnt3_RT(graph1, k1, maxCycles1, maxTime1, nAnts1);
    std::cout << "Test Case 1 - Triangle Graph: Conflicts = " << result1.conflicts << "\n";

    // Test Case 2: Square Graph
    Graph graph2 = {
        {0, 1, 0, 1},
        {1, 0, 1, 0},
        {0, 1, 0, 1},
        {1, 0, 1, 0}
    };
    int k2 = 2, maxCycles2 = 50, maxTime2 = 1000, nAnts2 = 10;
    Solution result2 = ColorAnt3_RT(graph2, k2, maxCycles2, maxTime2, nAnts2);
    std::cout << "Test Case 2 - Square Graph: Conflicts = " << result2.conflicts << "\n";
}

int main() {
    testColorAnt3RT();
    return 0;
}