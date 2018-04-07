#include <iostream>
#include <string>
using namespace std;

class Solution {

private:
    bool check(string &s, int* cache, int lb, int rb, int center) {
        int cover_center = lb + rb;
        int old_center = cover_center * 2 - center;
        int old_length = cache[old_center];

        int r_center = center / 2;
        int l_center = center - r_center;

        return lb >= l_center - old_length || rb <= r_center + old_length;
    }

    pair<int, int> generate(string &s, int* cache, int lb, int rb, int center) {
        int cover_center = lb + rb;
        int old_center = cover_center * 2 - center;
        int old_length = cache[old_center];

        int r_center = center / 2;
        int l_center = center - r_center;

        int new_length = min(l_center - lb, rb - r_center);

        return make_pair(l_center - new_length, r_center + new_length);
    }

    pair<int, int> grow(string &s, int lb, int rb) {
        if (lb <= 0 || rb + 1 >= s.length())return make_pair(lb, rb);
        if (s[lb - 1] != s[rb + 1])return make_pair(lb, rb);

        return grow(s, lb - 1, rb + 1);
    }

public:
    string longestPalindrome(string s) {
        if (s == "")return "";
        int length = s.length();
        int *cache = (int *)calloc(length * 2 + 1, sizeof(int));
        cache += 1;

        int lb = 0, rb = 0, max = 1, start = 0;

        // cout << s.length() << " " << (-1 < (s.length() * 2)) << " " << (-1<2) << endl;
        for (int i = -1; i < length * 2; i++) {
            // cout << s << " " << lb << " " << rb << " " << i << " " << check(s, cache, lb, rb, i) << endl;
            if (check(s, cache, lb, rb, i)) {
                pair<int, int> range;
                range = generate(s, cache, lb, rb, i);
                range = grow(s, range.first, range.second);
                lb = range.first;
                rb = range.second;

                cout << range.first << " " << range.second << endl;

                int new_length = rb - lb + 1;
                cache[i] = new_length;
                if (new_length > max) {
                    max = new_length;
                    start = lb;
                }
            }
        }

        return s.substr(start, max);
    }
};
