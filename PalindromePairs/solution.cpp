#include "inc.cpp"

struct trie {
    char ch;
    int index;
    
    trie *next[26];
};

trie *add(trie *t, char ch) {
    if (t->next[ch - 'a'] == 0) {
        trie *next = (trie *)calloc(1, sizeof(trie));
        next->ch = ch;
        next->index = -1;
        
        t->next[ch - 'a'] = next;
    }
    
    trie *next = t->next[ch - 'a'];
    return next;
}

void listAll(vector<int>& indices, trie *t) {
    if (t == 0)return;
    if (t->index > -1)indices.push_back(t->index);
    
    for (int i = 0; i < 26; i++) {
        listAll(indices, t->next[i]);
    }
}

bool palindrome(string s, int lp, int rp) {
    if (lp >= rp)return true;
    if (s[lp] == s[rp])return palindrome(s, lp + 1, rp - 1);
    return false;
}

class Solution {
public:
    vector<vector<int>> palindromePairs(vector<string>& words) {
        trie *r = (trie *)calloc(1, sizeof(trie));
        r->index = -1;
        
        for (int i = 0; i < words.size(); i++) {
            trie *n = r;
            for (int j = words[i].size() - 1; j >= 0; j--) {
                n = add(n, words[i][j]);
            }
            n->index = i;
        }
        
        trie *f = (trie *)calloc(1, sizeof(trie));
        f->index = -1;
        
        for (int i = 0; i < words.size(); i++) {
            trie *n = f;
            for (int j = 0; j < words[i].size(); j++) {
                n = add(n, words[i][j]);
            }
            n->index = i;
        }
        
        vector<vector<int>> result;
        
        for (int i = 0; i < words.size(); i++) {
            trie *n = r;
            for (int j = 0; j < words[i].size(); j++) {
                n = n->next[words[i][j] - 'a'];
                if (n == 0)break;
            }
            
            vector<int> indices;
            listAll(indices, n);
            
            for (int j = 0; j < indices.size(); j++) {
                if (i != indices[j]) {
                    int rp = words[indices[j]].size() - 1;
                    rp -= words[i].size();
                    if (palindrome(words[indices[j]], 0, rp))result.push_back(vector<int>({i, indices[j]}));
                }
            }
        }
        
        for (int i = 0; i < words.size(); i++) {
            trie *n = f;
            for (int j = words[i].size() - 1; j >= 0; j--) {
                n = n->next[words[i][j] - 'a'];
                if (n == 0)break;
            }
            
            vector<int> indices;
            listAll(indices, n);
            
            for (int j = 0; j < indices.size(); j++) {
                if (i != indices[j] && words[i].size() != words[indices[j]].size()) {
                    int lp = words[i].size();
                    if (palindrome(words[indices[j]], lp, words[indices[j]].size() - 1))result.push_back(vector<int>({indices[j], i}));
                }
            }
        }
        
        return result;
    }
};
