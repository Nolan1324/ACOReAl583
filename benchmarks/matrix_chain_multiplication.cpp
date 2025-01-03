// C++ code to implement the 
// matrix chain multiplication using recursion
#include <bits/stdc++.h>
using namespace std;

// Matrix Ai has dimension arr[i-1] x arr[i]
int minMultRec(vector<int> &arr, int i, int j) {

    // If there is only one matrix
    if (i + 1 == j)
        return 0;

    int res = INT_MAX;

    // Place the first bracket at different
    // positions or k and for every placed
    // first bracket, recursively compute
    // minimum cost for remaining brackets
    // (or subproblems)
    for (int k = i + 1; k < j; k++) {
        int curr = minMultRec(arr, i, k) + 
        minMultRec(arr, k, j) + arr[i] * arr[k] * arr[j];

        res = min(curr, res);
    }

    // Return minimum count
    return res;
}

int matrixMultiplication(vector<int> &arr) {
  
      int n = arr.size();
    return minMultRec(arr, 0, n - 1);
}

int main() {
  
    vector<int> arr = {1, 2, 3, 4, 3};
    cout << matrixMultiplication(arr);
    std::mt19937 gen(42); 
    std::uniform_int_distribution<int> dist(1, 20);
    vector<int> arr1 = {};
    for(int k = 2; k < 22; k++) { //change k to change runtime
        arr1 = {};
        for(int i = 0; i < k; i++) {
            arr1.push_back(dist(gen));
        }
        cout << matrixMultiplication(arr1);
    }
    
    return 0;
}