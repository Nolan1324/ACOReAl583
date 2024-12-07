#include <algorithm>
#include <cstdlib>
#include <ctime>
#include <iostream>
#include <vector>

int main() {
  std::srand(0);

  const size_t SIZE = 50000000;

  std::vector<int> numbers(SIZE);
  for (size_t i = 0; i < SIZE; ++i) {
    numbers[i] = std::rand();
  }

  std::sort(numbers.begin(), numbers.end());

  std::cout << "First 10 sorted numbers: ";
  for (size_t i = 0; i < 10; ++i) {
    std::cout << numbers[i] << " ";
  }
  std::cout << std::endl;

  return 0;
}