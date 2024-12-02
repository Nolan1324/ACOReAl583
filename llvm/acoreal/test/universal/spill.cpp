#include <iostream>
#include <cstdlib>

// Prevent optimization by making operations opaque
volatile int opaque(int x) {
  return x * x;
}

int main() {
  const int N = 10000; // Large loop count
  const int K = 128;   // Number of live variables

  // Create a large number of live variables
  int variables[K];
  for (int i = 0; i < K; ++i) {
    variables[i] = std::rand() % 100;
  }

  // Perform operations on all variables in a tight loop
  for (int iter = 0; iter < N; ++iter) {
    for (int i = 0; i < K; ++i) {
      variables[i] = opaque(variables[i] + iter);
    }
  }

  // Use the variables to ensure they're not optimized away
  int sum = 0;
  for (int i = 0; i < K; ++i) {
    sum += variables[i];
  }

  std::cout << "Sum: " << sum << std::endl;

  return 0;
}