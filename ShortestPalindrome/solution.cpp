#include <string>
using namespace std;

class Solution {
    private:
    bool check(string s, int lp, int rp) {
        if (lp < 0)return true;
        if (s[lp] != s[rp])return false;
        
        return check(s, lp - 1, rp + 1);
    }
    
    string gen(string s) {
        string str = s;
        for (int i = 0; i < str.length()/2; i++) {
            char tmp = str[i];
            str[i] = str[str.length() - 1 - i];
            str[str.length() - 1 - i] = tmp;
        }
        
        return str;
    }
public:
    string shortestPalindrome(string s) {
        if (s == "")return "";
        
        int rp = s.length() - (s.length() + 1)/2;
        while (rp > 0) {
            if (check(s, rp, rp))return gen(s.substr(rp + 1, s.length() - 1 - rp)) + s.substr(rp, 1) + s.substr(rp + 1, s.length() - 1 - rp);
            if (check(s, rp - 1, rp))return gen(s.substr(rp, s.length() - rp)) + s.substr(rp, s.length() - rp);
            rp--;
        }
        
        return gen(s.substr(1, s.length() - 1)) + s;
    }
};
