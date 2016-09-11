#include "inc.cpp"
#include "solution.cpp"

int main() {
  Solution s;
  vector<string> a({"abcd","dcba","lls","s","sssll"});
  vector<vector<int>> r = s.palindromePairs(a);
  for (auto p : r) {
    for (auto i : p)cout << i << " ";
    cout << endl;
  }
  //cout << s.palindromePairs(a) << endl;
}
