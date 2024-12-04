#include <iostream>
#include <vector>
#include <cmath>
#include <limits>
#include <chrono>
#include "math.h"
#include <random>
#include <omp.h>

#include "ACOGraphColoring.h"

using namespace std;

std::chrono::high_resolution_clock::time_point start_time;
std::chrono::high_resolution_clock::time_point previous_end_time;

float cumulative_percentage = 0.0;
int call_count = 0;
int print_frequency = 1;  // Print the average every n calls

void profileStart() {
    start_time = std::chrono::high_resolution_clock::now();
}

void profileStop() {
    auto end_time = std::chrono::high_resolution_clock::now();

    // Use nanoseconds for higher precision
    auto active_duration = std::chrono::duration_cast<std::chrono::nanoseconds>(end_time - start_time);

    if (previous_end_time.time_since_epoch().count() == 0) {
        previous_end_time = end_time;
        return;  // No interval to calculate for the first call
    }

    // Use nanoseconds for total interval calculation as well
    auto total_interval = std::chrono::duration_cast<std::chrono::nanoseconds>(end_time - previous_end_time);
    previous_end_time = end_time;

    float active_time_ns = active_duration.count();  // Nanoseconds as a raw value
    float total_time_ns = total_interval.count();    // Nanoseconds as a raw value

    if (total_time_ns == 0) {
        std::cout << "Total time is too small, skipping calculation..." << std::endl;
        return;
    }

    // Calculate the percentage
    float percentage = (active_time_ns / total_time_ns) * 100.0;

    // Accumulate percentages and count calls
    cumulative_percentage += percentage;
    ++call_count;

    // Print the average every `print_frequency` calls
    if (call_count % print_frequency == 0) {
        float average_percentage = cumulative_percentage / print_frequency;
        std::cout << "Average active time percentage (last " << print_frequency
                  << " calls): " << average_percentage << "%" << std::endl;
        cumulative_percentage = 0.0;  // Reset cumulative percentage
    }
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


static void updatePheromones(const Graph& graph, vector<vector<float>>& pheromones, Parameters& params, const Solution& colonyBest, const Solution& antBest, int cycle, int& pheroCounter) {
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


inline float fastPow(float a, float b) {
    return exp(b * log(a));
}

inline static float assignmentWeight(int vertex, int color, Parameters& params, vector<vector<int>>& neighborsByColor, vector<vector<float>>& pheromoneTrails) {
    // pheromoneTrail * heuristic * isAllowed
    // For heuristic, paper doesn't add 1 to denominator, repo does. Without adding one, gets /0 error
    return fastPow(pheromoneTrails[vertex][color], params.alpha)
         * fastPow(neighborsByColor[vertex][color] + 1, -params.beta)
         * params.allowedColors[vertex][color];
}

static int bestColor(int vertex, Parameters& params, vector<vector<int>>& neighborsByColor, vector<vector<float>>& pheromoneTrails, mt19937& gen) {
    float weights[params.numColors];
    for (int color = 0; color < params.numColors; ++color) {
        weights[color] = assignmentWeight(vertex, color, params, neighborsByColor, pheromoneTrails);
    }

    discrete_distribution<> dist(weights, weights + params.numColors);
    return dist(gen);
}

static void antFixedK(Solution& solution, const Graph& graph, Parameters& params, const vector<vector<float>>& pheromones) {
    vector<vector<int>> neighborsByColor(params.numVertices, vector<int>(params.numColors, 0)); // store saturation directly here later (n+1)
    vector<int> numWithColor(params.numColors, 0);
    vector<vector<float>> pheramoneTrails(params.numVertices, vector<float>(params.numColors, 1.0));

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
        
        int color = bestColor(chosenVertex, params, neighborsByColor, pheramoneTrails, gen);
        solution.vertexColors[chosenVertex] = color;
        numWithColor[color]++;
        for (int u = 0; u < params.numVertices; ++u) {
            // pheramoneTrails[u][c] = (sum_{v colored c} pheramones[u][v]) / (num colored c)
            pheramoneTrails[u][color] *= (numWithColor[color] - 1.0) / numWithColor[color];
            float epsilon = 0.0000000001;
            pheramoneTrails[u][color] += (pheromones[u][chosenVertex] + epsilon) / numWithColor[color];
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
    
    auto duration = std::chrono::duration<float>(params.maxTabucolTime);
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
    vector<vector<float>> pheromones(params.numVertices, vector<float>(params.numVertices, 1.0));
    
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
    auto duration = std::chrono::duration<float>(params.maxTime); // Run for maxTime seconds
    auto start = std::chrono::steady_clock::now(); // Record the start time

    while (cycles < params.maxCycles && bestSolutionValue > 0 && std::chrono::steady_clock::now() - start < duration) {
        // if (cycles % 10 == 0) {
        //     cout << "Starting cycle " << cycles << endl;
        // }
        int bestAntValue = numeric_limits<int>::max();
        Solution antBest(params.numVertices);

        profileStart();
        omp_lock_t lock;
        omp_init_lock(&lock);
        #pragma omp parallel for
        for (int ant = 1; ant <= params.numAnts; ++ant) {
            Solution s(params.numVertices);
            antFixedK(s, graph, params, pheromones);
            reactTabucol(s, graph, params);

            int localBestValue = optimizationFunction(s);
            if (s.conflictingEdges == 0 || localBestValue < bestAntValue) {
                omp_set_lock(&lock);
                if (localBestValue < bestAntValue) {
                    bestAntValue = localBestValue;
                    antBest = s;
                }
                omp_unset_lock(&lock);
            }
        }
        omp_destroy_lock(&lock);
        profileStop();
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
    for (int spill = 0; spill < params.maxSpilled; ++i) {
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
}