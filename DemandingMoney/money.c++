#include <cmath>
#include <cstdio>
#include <queue>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <iostream>
#include <algorithm>
using namespace std;

unsigned long long int ONE = 1;
    
vector<int> toV(unsigned long long int &item) {
    vector<int> l;
    for (int i = 0; item > 0; i++) {
        if (item % 2 == 1)l.push_back(i);
        item = item >> 1;
    }
    
    return l;
}

unsigned long long int fromV(vector<int> &vs) {
    if (vs.empty())return 0;

    unsigned long long int item = 0;    
    for (int v : vs) {
        item |= ONE << v;
    }
    
    return item;
}

vector<vector<int>> partition(unordered_map<int, vector<int>> &g) {
    vector<unordered_set<int>> comps;
    for (int i = 0; i < g.size(); i++) {
        comps.push_back(unordered_set<int>());
        comps.back().insert(i);
    }
    
    for (pair<int, vector<int>> p : g) {
        vector<int> vs = p.second;
        vs.push_back(p.first);
        
        unordered_set<int> ncomp;
        vector<unordered_set<int>> ncomps;
        for (unordered_set<int> comp : comps) {
            bool absorbed = false;
            for (int i : vs) {
                if (comp.count(i) > 0) {
                    absorbed = true;
                    for (int j : comp)ncomp.insert(j);
                }
            }
            
            if (!absorbed)ncomps.push_back(comp);
        }
        ncomps.push_back(ncomp);
        comps = ncomps;
    }
    
    vector<vector<int>> lst;
    for (unordered_set<int> comp : comps) {
        lst.push_back(vector<int>());
        for (int i : comp) {
            lst.back().push_back(i);
        }
    }
    
    return lst;
}

int solve(vector<int> &cs, unordered_map<int, vector<int>> &g, vector<int> &comp, unsigned long long int &factor) {
    unordered_map<unsigned long long int, unsigned long long int> cljs;
    unordered_map<unsigned long long int, unsigned short> vals;
    unordered_map<unsigned long long int, bool> covers;
    
    unsigned long long int vs = fromV(comp);
    int cur = 0, count = 1;
    
    vals[vs] = cur;
    cljs[vs] = 0;
    covers[vs] = true;
    queue<unsigned long long int> wl({vs});
    
    while (wl.size() > 0) {
        unsigned long long int item = wl.front();
        wl.pop();
        unsigned long long int clj = cljs[item];
        unsigned long long int itemf = item & (~clj);
        if (itemf == 0) {
            continue;
        }
        
        int bal = vals[item];
        vector<int> vs = toV(itemf);
        for (int v : vs) {
            int val = cs[v];
            
            unsigned long long int nclj = fromV(g[v]) | clj | (ONE << v);
            unsigned long long int nitem = item ^ (ONE << v);
            cljs[nitem] = nclj;
            
            if (vals[nitem] < bal + val || !covers[nitem]) {
                vals[nitem] = bal + val;
                
                if (vals[nitem] > cur) {
                    cur = vals[nitem];
                    count = 0;
                }
                if (vals[nitem] == cur)count++;   
            }
            
            if (covers[nitem]) {
                continue;
            } else {
                covers[nitem] = true;
                wl.push(nitem);
            }                   
        }
    }
    factor *= count;
    
    return cur;
}

int main() {
    /* Enter your code here. Read input from STDIN. Print output to STDOUT */
    int n, m;
    cin >> n >> m;
    
    unsigned long long int size = ONE << n;
    
    vector<int> cs;
    vector<int> zs;
    for (int i = 0; i < n; i++) {
        int c;
        cin >> c;
        cs.push_back(c);
        if (c == 0)zs.push_back(i);
    }
    unsigned long long int zv = fromV(zs);
    
    unordered_map<int, vector<int>> g;
    for (int i = 0; i < n; i++) {
        g[i] = vector<int>();
    }
    
    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        a--;
        b--;
        
        g[a].push_back(b);
        g[b].push_back(a);
    }
    
    vector<vector<int>> comps = partition(g);
    
    unsigned long long int cur = 0, count = 1;
    
    for (vector<int> comp : comps) {
        cur += solve(cs, g, comp, count);
    }
    
    cout << cur << " " << count << endl;
    
    return 0;
}