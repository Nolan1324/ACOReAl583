#include <iostream>
#include <vector>
#include <cmath>
#include <limits>
#include <chrono>
#include "math.h"
#include <random>

#include "ACOGraphColoring.h"

// TODO: Register constrains

using namespace std;

std::chrono::high_resolution_clock::time_point start_time;

// Function to start profiling
void profileStart() {
    start_time = std::chrono::high_resolution_clock::now();  // Record start time
}

// Function to stop profiling and print elapsed time in milliseconds
void profileStop() {
    auto end_time = std::chrono::high_resolution_clock::now();    // Record end time
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end_time - start_time);  // Calculate duration

    // Convert microseconds to milliseconds and print with decimal point
    double milliseconds = duration.count() / 1000.0;
    std::cout << "Time taken: " << milliseconds << " milliseconds" << std::endl;
}


class LocalStep {
public:
    int vertex;
    int color;
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


static void updatePheromones(const Graph& graph, vector<vector<double>>& pheromones, Parameters& params, const Solution& colonyBest, const Solution& antBest, int cycle, int& pheroCounter) {
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

static int optimizationFunction(const Solution& solution) {
    return solution.conflictingEdges;
}

// if this is a bottleneck can redo saturation storing
static int saturation(const vector<int>& neighborsByColor) {
    int saturationVal = 0;
    for (size_t i = 0; i < neighborsByColor.size(); ++i) {
        if (neighborsByColor[i] > 0) {
            saturationVal += 1;
        }
    }
    return saturationVal;
}

static double pheromoneTrail(int vertex, int color, Solution& solution, const vector<vector<double>>& pheromones) {
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

static double heuristic(int vertex, int color, vector<vector<int>>& neighborsByColor) {
    // Paper doesn't add 1 to denominator, repo does. Without adding one, gets /0 error
    return 1.0 / (neighborsByColor[vertex][color] + 1);
}

static double assignmentWeight(int vertex, int color, Parameters& params, vector<vector<int>>& neighborsByColor, Solution& solution, const vector<vector<double>>& pheromones) {
    return pow(pheromoneTrail(vertex, color, solution, pheromones), params.alpha)
         * pow(heuristic(vertex, color, neighborsByColor), params.beta)
         * params.allowedColors[vertex][color];
}

static int bestColor(int vertex, Parameters& params, vector<vector<int>>& neighborsByColor, Solution& solution, const vector<vector<double>>& pheromones, mt19937& gen) {
    vector<double> weights;
    weights.reserve(params.numColors);
    for (auto color = 0; color < params.numColors; ++color) {
        weights.push_back(assignmentWeight(vertex, color, params, neighborsByColor, solution, pheromones));
    }
    
    discrete_distribution<> dist(weights.begin(), weights.end());
    int selection = dist(gen);
    return selection;
}

static void antFixedK(Solution& solution, const Graph& graph, Parameters& params, const vector<vector<double>>& pheromones) {
    vector<vector<int>> neighborsByColor(params.numVertices, vector<int>(params.numColors, 0)); // store saturation directly here later (n+1)
    
    int numUncolored = params.numVertices;
    random_device randomDevice;
    mt19937 gen(randomDevice()); // psuedo-RNG
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
        
        
        int color = bestColor(chosenVertex, params, neighborsByColor, solution, pheromones, gen);
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
static void countConflicts(vector<vector<int>>& conflicts, const Graph& graph, Solution& solution, Parameters& params) {
    for (int i = 0; i < params.numVertices; i++) {
        for (int j = 0; j < params.numVertices; j++) {
            if (graph[i][j]) {
                conflicts[solution.vertexColors[j]][i]++;
            }
        }
    }
}


static void updateSolution(Solution& solution, const Graph& graph, const Parameters& params, const LocalStep& step, vector<vector<int>>& conflicts, vector<vector<int>>& tabuTenure, int newTenure) {
    int vertex = step.vertex;
    int oldColor = solution.vertexColors[vertex];
    int newColor = step.color;
    solution.conflictingEdges += conflicts[newColor][vertex] - conflicts[oldColor][vertex];
    solution.vertexColors[vertex] = newColor;


    for (int neighbor = 0; neighbor < params.numVertices; ++neighbor) {
        if (!graph[vertex][neighbor]) continue;

        conflicts[oldColor][neighbor]--;
        conflicts[newColor][neighbor]++;
    }

    tabuTenure[vertex][newColor] = newTenure;
}

static void reactiveTenureUpdate(int& tabuTenureLength, int& iteration, int& totalConflicts,
                      int& maxSolutionValue, int& minSolutionValue, const Parameters& params) {
    // Predefined parameter pairs: {frequency, increment, nextPair}
    static int pairs[][3] = {
        {10000, 10, 5}, {10000, 15, 3}, {10000, 5, 10}, {5000, 15, 10},
        {5000, 10, 15}, {5000, 5, 20}, {1000, 15, 30}, {1000, 10, 50},
        {1000, 5, 100}, {500, 5, 100}, {500, 10, 150}, {500, 15, 200}
    };

    static int pairCycles = 0;
    static int frequency = pairs[0][0];
    static int increment = pairs[0][1];
    static int nextPair = pairs[0][2];
    static int numPairs = sizeof(pairs) / sizeof(pairs[0]);

    int maxMin = 0;

    // Update max and min solution values
    maxSolutionValue = std::max(maxSolutionValue, totalConflicts);
    minSolutionValue = std::min(minSolutionValue, totalConflicts);

    maxMin = maxSolutionValue - minSolutionValue;

    if (iteration % frequency == 0) {
        // Adjust tabu tenure
        if (maxMin < (4 + totalConflicts / 80) || tabuTenureLength == 0) {
            tabuTenureLength += increment;

            if (pairCycles == nextPair) {
                // Select a new parameter pair
                int randomIndex = rand() % numPairs;
                frequency = pairs[randomIndex][0];
                increment = pairs[randomIndex][1];
                nextPair = pairs[randomIndex][2];
                pairCycles = 0;
            }
        } else if (tabuTenureLength > 0) {
            tabuTenureLength--;
        }

        // Reset solution value tracking
        minSolutionValue = params.numVertices * params.numVertices;
        maxSolutionValue = 0;

        if (pairCycles == nextPair) {
            // Select a new parameter pair
            int randomIndex = rand() % numPairs;
            frequency = pairs[randomIndex][0];
            increment = pairs[randomIndex][1];
            nextPair = pairs[randomIndex][2];
            pairCycles = 0;
        } else {
            pairCycles++;
        }
    }
}

static void dynamicTenureUpdate(int& tabuTenureLength, int numVertexConflicts) {
    // Create a random number generator
    static std::mt19937 generator{std::random_device{}()}; // Seed the generator
    std::uniform_int_distribution<int> distribution(0, 9); // Generate numbers in the range [0, 9]

    // Generate a random number and calculate tabuTenureLength
    int randomValue = distribution(generator);
    tabuTenureLength = static_cast<int>(0.6 * numVertexConflicts) + randomValue;
}

static int countConflictingVertices(const Solution& solution, const Graph& graph, const Parameters& params) {
    int numConflicts = 0;

    // Iterate through each vertex and its neighbors
    for (int i = 0; i < params.numVertices; i++) {
        for (int j = 0; j < params.numVertices; j++) {
            if (graph[i][j] && solution.vertexColors[i] == solution.vertexColors[j]) {
                numConflicts++;
                break; // Count the vertex only once
            }
        }
    }

    return numConflicts;
}

static void reactTabucol(Solution& solution, const Graph& graph, Parameters& params) {
    int currentIteration = 1;
    int tabuLength = params.numVertices / 10;
    vector<vector<int>> tabuTenure(params.numVertices, vector<int>(params.numColors, currentIteration));
    vector<vector<int>> conflicts(params.numColors, vector<int>(params.numVertices, 0));
    countConflicts(conflicts, graph, solution, params);
    
    auto duration = std::chrono::duration<double>(params.maxTabucolTime);
    auto start = std::chrono::steady_clock::now();

    // TODO: Create exit condition for if it's already a perfect solution
    while (currentIteration < params.maxTabulcolCycles && std::chrono::steady_clock::now() - start < duration) {
        vector<int> conflictingVertices;
        for (int i = 0; i < params.numVertices; i++) {
            if (conflicts[solution.vertexColors[i]][i] > 0) {
                //totalConflicts += conflicts[solution->color_of[i]][i];
                //nodes_in_conflict[0]++;
                //conf_position[i] = nodes_in_conflict[0];
                conflictingVertices.push_back(i);
            }
        }
        int bestValue = numeric_limits<int>::max();
        int bestVertex = -1;
        int bestColor = -1;
        for (int v: conflictingVertices) {
            for (int c = 0; c < params.numColors; c++) {
                // If the virtual register cannot be assigned to this type of phisical register, skip it
                if (!params.allowedColors[v][c]) {
                    continue;
                }

                int newValue = solution.conflictingEdges + conflicts[c][v] - conflicts[solution.vertexColors[v]][v];
                bool localBest = newValue <= bestValue;
                bool tabu = tabuTenure[v][c] >= currentIteration;
                if (localBest && !tabu) {
                    bestValue = newValue;
                    bestVertex = v;
                    bestColor = c;
                }
            }
        }
        // TODO: Fix the following if to randomize if all choices are tabu
        bool allTabu = (bestVertex == -1);
        if (allTabu) {
            int v = 0;
            int c = 0;
            while (!params.allowedColors[v][c]) {
                c++;
            }
            // if (!params.allowedColors[v][c]) {
            //     printf("baad\n");
            // }
            bestValue = solution.conflictingEdges + conflicts[c][v] - conflicts[solution.vertexColors[v]][v];
            bestVertex = v;
            bestColor = c;
        }
        // END TODO

        LocalStep bestStep = {bestVertex, bestColor};
        int newTenure = currentIteration + tabuLength;
        updateSolution(solution, graph, params, bestStep, conflicts, tabuTenure, newTenure);
        // This is probably worth calculating elsewhere
        int numVertexConflicts = countConflictingVertices(solution, graph, params);
        dynamicTenureUpdate(tabuLength, numVertexConflicts);
        // TODO: Make reactive tenure work
        // reactiveTenureUpdate(tabuLength, currentIteration, 
        // int& totalConflicts, int& maxSolutionValue, int& minSolutionValue, const Parameters& params)
        currentIteration++;
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
        //cout << "Starting cycle " << cycles << endl;
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
        return;
    }
    solution.vertexColors[spillNode] = -1;
}