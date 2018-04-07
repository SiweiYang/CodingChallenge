#include <iostream>
#include <string>
#include "solution.cpp"

int main() {
  Solution s;
  string str;
  str = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
  cout << s.longestPalindrome(str) << endl;


  str = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb";
  cout << s.longestPalindrome(str) << endl;
}
