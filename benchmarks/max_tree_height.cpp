// C++ code to find the maximum path length
// considering any node as root
#include <bits/stdc++.h>
using namespace std;

class Node{
public:
    int data;
    vector<Node*> children;
    Node(int x) {
        data = x;
    }
};

// function to pre-calculate the in[]
// which stores the maximum height when travelled
// via branches
int dfs1(Node* root, unordered_map<Node*,int> &in) {
    
    int ans = 0;
    
    for (Node* child: root->children) {
        ans = max(ans, 1+dfs1(child, in));
    }
    
    return in[root] = ans;
}

// function to pre-calculate the array out[]
// which stores the maximum height when traveled
// via parent
void dfs2(Node* root, unordered_map<Node*,int> &out, 
unordered_map<Node*,int> &in) {
    
    // stores the longest and second 
    // longest branches
    int mx1 = -1, mx2 = -1;

    // traverse in the subtrees of root
    for (Node* child : root->children) {

        // compare and store the longest
        // and second longest
        if (in[child] >= mx1) {
            mx2 = mx1;
            mx1 = in[child];
        }

        else if (in[child] > mx2)
            mx2 = in[child];
    }

    // traverse in the subtree of root
    for (Node* child : root->children) {
        int longest = mx1;

        // if longest branch has the node, then
        // consider the second longest branch
        if (mx1 == in[child])
            longest = mx2;

        // recursively calculate out[i]
        out[child] = 1 + max(out[root], 1 + longest);

        // dfs function call
        dfs2(child, out,in);
    }
}

// function to get maximum height.
int maxHeight(Node* root) {
    unordered_map<Node*,int> in, out;
    
    // traversal to calculate in values
    dfs1(root, in);

    // traversal to calculate out values
    dfs2(root, out, in);
    
    int ans = 0;

    for (auto p: in) {
        Node* node = p.first;
        ans = max({ans, in[node], out[node]});
    }
    
    return ans;
}

int main() {
  
    Node* root = new Node(1);
    Node* node1 = new Node(2);
    Node* node2 = new Node(3);
    Node* node3 = new Node(4);
    Node* node4 = new Node(5);
    Node* node5 = new Node(6);
    Node* node6 = new Node(7);
    Node* node7 = new Node(8);
    Node* node8 = new Node(9);
    Node* node9 = new Node(10);
    Node* node10 = new Node(11);

    root->children.push_back(node1);
    root->children.push_back(node2);
    root->children.push_back(node3);
    node1->children.push_back(node4);
    node1->children.push_back(node5);
    node2->children.push_back(node6);
    node3->children.push_back(node7);
    node3->children.push_back(node8);
    node6->children.push_back(node9);
    node6->children.push_back(node10);
    
    cout << maxHeight(root);

    return 0;
}
