// C++ program to find minimum step required to
// visit all houses.

#include <bits/stdc++.h>
using namespace std;

int findMinSteps(vector<vector<char>> &mat) {
    int n = mat.size();
    int m = mat[0].size();

    // Transforming the grid: assign unique IDs to
      // houses and mark obstacles Grid to store houses and obstacles
    vector<vector<int>> grid(n, vector<int>(m, 0));
    int houseId = 0;
    int startX = 0, startY = 0;

    // Process the grid and assign unique IDs to houses, 
      // and find starting position
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (mat[i][j] == '.') {
              
                // Open cell, marked as 0
                grid[i][j] = 0;
            }
            else if (mat[i][j] == '*') {
              
                // Assign unique ID to each house
                grid[i][j] = houseId++;
            }
            else if (mat[i][j] == 'o') {
              
                // Record starting row and column
                startX = i;
                startY = j;
            }
            else {
                // Mark obstacles as -1
                grid[i][j] = -1;
            }
        }
    }

    // If there are no houses to visit, return 0
    if (houseId == 0)
        return 0;

    // BFS setup: Visited array and queue
    vector<vector<vector<int>>> vis(1 << houseId, 
    vector<vector<int>>(n, vector<int>(m, 0)));

    // BFS queue to store (visitedMask, x, y)
    queue<vector<int>> q;

    // Mark the starting position as visited
    vis[0][startX][startY] = 1;

    // Push the initial state (0 mask, startX, startY)
    q.push({0, startX, startY});

    // Counter for the number of steps
    int steps = 0;

    // Directions for BFS traversal: right, left, down, up
    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    // BFS loop
    while (!q.empty()) {
        int qSize = q.size();

        for (int idx = 0; idx < qSize; idx++) {
            auto curr = q.front();
            q.pop();

            // Mask of visited houses
            int mask = curr[0];

            // Current x position
            int x = curr[1];

            // Current y position
            int y = curr[2];

            // If all houses are visited, return
              // the steps taken
            if (mask == (1 << houseId) - 1) {
                return steps;
            }

            // Explore all possible moves (right, left, down, up)
            for (int k = 0; k < 4; k++)  {
              
                // Calculate new x  and y position.
                int newX = x + dx[k];
                int newY = y + dy[k];

                // Check boundaries and ensure it's not a blocked cell
                if (newX >= 0 && newX < n && newY >= 0 
                    && newY < m && grid[newX][newY] != -1) {
                    if (mat[newX][newY] == '*') {
                      
                        // If it's a house, update the visited mask
                        int newMask = mask | (1 << grid[newX][newY]);

                        // If the new state is already visited, continue
                        if (vis[newMask][newX][newY])
                            continue;

                        // Mark the new state as visited
                        vis[newMask][newX][newY] = 1;
                      
                        // Push the new state to the queue
                        q.push({newMask, newX, newY});
                    }
                    else {
                      
                        // If it's a normal cell, continue without
                          // updating the mask
                        if (vis[mask][newX][newY])
                            continue;

                        vis[mask][newX][newY] = 1;
                        q.push({mask, newX, newY});
                    }
                }
            }
        }
      
        // Increment step count after processing all
          // states at the current level
        steps++;
    }

    // If unable to visit all houses, return -1
    return -1;
}

int main() {

    vector<vector<char>> mat = {{'.', '.', '.', '.', '.', '.', '.'},
                                {'.', 'o', '.', '.', '.', '*', '.'},
                                {'.', '.', '.', '.', '.', '.', '.'},
                                {'.', '*', '.', '.', '.', '*', '.'},
                                {'.', '.', '.', '.', '.', '.', '.'}};

    int res = findMinSteps(mat);
    cout << res << endl;

    return 0;
}