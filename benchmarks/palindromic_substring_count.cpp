// C++ program to count all palindromic substring of
// given string by generating all possible substrings

#include <iostream>
#include <string>
#include <random>
using namespace std;

// Function to check if a substring 
// s[i..j] is a palindrome
bool isPalindrome(string& s, int i, int j) {
    while (i < j) {
        if (s[i] != s[j]) return false;
        i++;
        j--;
    }
    return true;
}

int countPS(string& s) {
    int n = s.length();  
   
    // Consider all possible substrings of lengths
    // more than 1
    int res = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i+1; j < n; j++) {
          
              // If substring from i to j is palindrome
              // increment the result
            if (isPalindrome(s, i, j)) 
                res++;  
        }
    }

    return res;
}

std::string generateRandomString(std::string str, int length, unsigned int seed = 42) {
	std::mt19937 generator(seed);
	std::uniform_int_distribution<char> distribution('a', 'z');
	std::string randomString;
    for (int i = 0; i < length; ++i) {
        randomString += distribution(generator);
    }
    return randomString;
}

int main() {
    string s = "aaa";
    cout << countPS(s);

    for (int i = 0; i < 999999; i++) { //change i to change benchmark length
		cout << i;
		generateRandomString(s, 500);
		cout << countPS(s) << endl;
	}
    return 0;
}

//Source: https://www.geeksforgeeks.org/count-palindrome-sub-strings-string/