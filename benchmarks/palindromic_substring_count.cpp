// C++ program to count all palindromic substring of
// given string by generating all possible substrings

#include <iostream>
#include <string>
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

int main() {
    string s = "aaa";
    cout << countPS(s);
    return 0;
}

//Source: https://www.geeksforgeeks.org/count-palindrome-sub-strings-string/