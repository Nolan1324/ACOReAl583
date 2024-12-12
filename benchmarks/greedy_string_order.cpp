// C++ program to rearrange a string so that all same
// characters become at least d distance away using STL
#include <bits/stdc++.h>
#include <iostream>
#include <random>
using namespace std;
typedef pair<char, int> PAIR;

// Comparator of priority_queue
struct cmp {
	bool operator()(const PAIR& a, const PAIR& b)
	{
		if(a.second < b.second) return true;
		else if(a.second > b.second) return false;
		else return a.first > b.first;
	}
};

void rearrange(char* str, int d)
{
	// Length of the string
	int n = strlen(str);

	// A structure to store a character and its frequency
	unordered_map<char, int> m;

	// Traverse the input string and store frequencies of
	// all characters.
	for (int i = 0; i < n; i++) {
		m[str[i]]++;
		str[i] = '\0';
	}

	// max-heap
	priority_queue<PAIR, vector<PAIR>, cmp> pq(m.begin(),
											m.end());

	// Now one by one extract all distinct characters from
	// heap and put them back in str[] with the d
	// distance constraint
	while (pq.empty() == false) {
		char x = pq.top().first;
		
		// Find the first available position in str[]
		int p = 0;
		while (str[p] != '\0')
			p++;
		
		// Fill x at p, p+d, p+2d, .. p+(frequency-1)d
		for (int k = 0; k < pq.top().second; k++) {
		
			// If the index goes beyond size, then string
			// cannot be rearranged.
			if (p + d * k >= n) {
				cout << "Cannot be rearranged";
				// exit(0);
			}
			str[p + d * k] = x;
		}
		pq.pop();
	}
}

void generateRandomString(char str[], int length, unsigned int seed = 42) {
	std::mt19937 generator(seed);
	std::uniform_int_distribution<char> distribution('a', 'z');
	for (int i = 0; i < length; ++i) {
		str[i] = distribution(generator);
	}
	str[length] = '\0';
}

// Driver Code
int main()
{
	char str[] = "aabbccddeeffgghhiijjkkllmmnnooppqqrrssttuuvvwwxxyyzz";

	for (int i = 0; i < 90000; i++) { //change i to change benchmark length
		cout << i;
		generateRandomString(str, 500);
		rearrange(str, 3);
		cout << str;
	}
	
	
}
