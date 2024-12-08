// C++ Code to Assign Unique Cap To Every Person
// using Recursion
#include <bits/stdc++.h>
using namespace std;

// Recursive function to calculate the number of ways
// to assign caps to people such that each person has
// a unique cap
int dfs(int assignedCount, vector<bool>& assignedPeople,
        int cap, vector<vector<int>>& capToPeople, int totalPeople) {
    
    // Base case: if all people have a cap assigned, return 1
    if (assignedCount == totalPeople) {
        return 1;
    }
    
    // If we've considered all caps and not everyone
    // has a cap, return 0
    if (cap > 100) {
        return 0;
    }

    // Case: skip the current cap
    int ways = dfs(assignedCount, assignedPeople, 
                   cap + 1, capToPeople, totalPeople);

    // Assign the current cap to each person who likes it
    for (int person : capToPeople[cap]) {

        // Check if the person already has a cap assigned
        if (!assignedPeople[person]) {
            
            // Assign current cap to the person
            assignedPeople[person] = true;
            
            // Recurse with increased assigned count
            ways = ways + dfs(assignedCount + 1, assignedPeople, 
                               cap + 1, capToPeople, totalPeople);
            
            // Backtrack: unassign the cap for other possibilities
            assignedPeople[person] = false;
        }
    }

    return ways;
}

// Main function to calculate the number of ways to assign caps
int numberWays(vector<vector<int>>& caps) {
    int n = caps.size();

    // Map each cap to the list of people who prefer it
    vector<vector<int>> capToPeople(101);
    for (int i = 0; i < n; ++i) {
        for (int cap : caps[i]) {
            capToPeople[cap].push_back(i);
        }
    }

    // Initialize assignedPeople vector to track
      // assigned caps
    vector<bool> assignedPeople(n, false);
    
    // Call the recursive function starting from the first cap
    return dfs(0, assignedPeople, 1, capToPeople, n);
}

int main() {
  
    vector<vector<int>> caps
        = {{1, 2, 3}, {1, 2}, {3, 4}, {4, 5}};
    
    cout << numberWays(caps) << endl;

    return 0;
}
