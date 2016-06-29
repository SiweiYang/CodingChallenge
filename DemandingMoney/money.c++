#include <cmath>
#include <cstdio>
#include <queue>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <iostream>
#include <algorithm>
using namespace std;

vector<int> toV(unsigned long long int item) {
    vector<int> l;
    for (int i = 0; item > 0; i++) {
        if (item % 2 == 1)l.push_back(i);
        item = item >> 1;
    }
    
    return l;
}

unsigned long long int fromV(vector<int> vs) {
    if (vs.empty())return 0;

    unsigned long long int item = 0;    
    for (int v : vs) {
        item |= 1 << v;
    }
    
    return item;
}

int main() {
    /* Enter your code here. Read input from STDIN. Print output to STDOUT */
    int n, m;
    cin >> n >> m;
    
    unsigned long long int size = 1 << n;
    
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
    
    unordered_map<unsigned long long int, unsigned long long int> cljs;
    int *vals = (int *)calloc(size, sizeof(int));
    cljs[size - 1] = 0;
    queue<unsigned long long int> wl({size - 1});
    
    vector<unsigned long long int> maximal;
    
    int cur = 0, count = 0;
    while (wl.size() > 0) {
        unsigned long long int item = wl.front();
        wl.pop();
        unsigned long long int clj = cljs[item];
        unsigned long long int itemf = item & (~clj);
        if (itemf == 0) {
            maximal.push_back(item);
            continue;
        }
        
        int bal = vals[item];
        vector<int> vs = toV(itemf);
        for (int v : vs) {
            int val = cs[v];
            
            vector<int> ext = g[v];
            ext.push_back(v);
            
            unsigned long long int nclj = fromV(ext) | clj;
            unsigned long long int nitem = item ^ (1 << v);
            cljs[nitem] = nclj;
            
            if (vals[nitem] >= bal + val)continue;
            if (vals[nitem] == 0)wl.push(nitem);
            
            vals[nitem] = bal + val;
            if (vals[nitem] < cur)continue;
            if (vals[nitem] > cur) {
                cur = vals[nitem];
                count = 0;
            }
            count++;          
        }
    }
    
    cout << cur << " " << count << endl;
    
    return 0;
}
