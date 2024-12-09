// C++ program to calculate the maximum amount one can collect
// using the optimal strategy from index i to index j
// using  memoziation
#include <random>
#include <bits/stdc++.h>
using namespace std;
int maxAmount(int i, int j, vector<int> &arr, 
              vector<vector<int>> &memo) {

    // Base case: If i > j, no more elements
    // are left to pick
    if (i > j)
        return 0;

    // If the result is already computed, return
    // from the dp table
    if (memo[i][j] != -1)
        return memo[i][j];

    // Option 1: Take the first element arr[i], and
    // then we have two choices:
    // - Skip arr[i+1] and solve the problem for
    // range [i+2, j]
    // - Take arr[i+1] and arr[j-1] (we solve the
    // problem for range [i+1, j-1])
    int takeFirst = arr[i] + min(maxAmount(i + 2, j, arr, memo), 
                                 maxAmount(i + 1, j - 1, arr, memo));

    // Option 2: Take the last element arr[j], and then we have
    // two choices:
    // - Skip arr[j-1] and solve the problem for range [i, j-2]
    // - Take arr[i+1] and arr[j-1] (we solve the problem for range
    //[i+1, j-1])
    int takeLast = arr[j] + min(maxAmount(i + 1, j - 1, arr, memo),
                                maxAmount(i, j - 2, arr, memo));

    // Store the maximum of the two choices
    return memo[i][j] = max(takeFirst, takeLast);
}

int maximumAmount(vector<int> &arr) {
  
      int n = arr.size();

    // Create a 2D DP table initialized to -1
      // (indicating uncalculated states)
    vector<vector<int>> memo(n, vector<int>(n, -1));

    int res = maxAmount(0, n - 1, arr, memo);

    return res;
}

int main() {
  
    vector<int> arr = {5, 3, 7, 10};
    std::mt19937 generator(42);
    for(int i = 0; i < 1500; i++) { //change i to change benchmark runtime
        int res = maximumAmount(arr);
        cout << res << endl;
        std::uniform_int_distribution<int> dist(0, 100); 
        arr.push_back(dist(generator));
    }
    

    // return 0;
}