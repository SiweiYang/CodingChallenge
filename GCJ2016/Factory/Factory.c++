#include <iostream>
#include <fstream>
#include <vector>
#include <tuple>
#include <algorithm>
#include <unordered_map>
#include <unordered_set>
#include <string.h>
using namespace std;

typedef struct {
    
} group;

vector<int> fromR(int n, int ms, bool *m, int r) {
    vector<int> ids;
    
    int offset = n * r;
    for (int i = 0; i < n; i++) {
        if (m[offset + i])ids.push_back(i);
    }
    
    return ids;
}

vector<int> fromC(int n, int ms, bool *m, int c) {
    vector<int> ids;
    
    for (int i = 0; i < n; i++) {
        if (m[n * i + c])ids.push_back(i);
    }
    
    return ids;
}

int compute(vector<pair<int, int>> css) {
    int total = 0;
    
    for (pair<int, int> p : css) {        
        total += p.first * p.first;
    }
    
    return total;
}

int opt(vector<pair<int, int>> pos, vector<pair<int, int>> neg) {
    if (neg.size() == 0)return compute(pos);
    
    pair<int, int> t = neg.back();
    neg.erase(neg.end());
    
    //printf("selecting (%d, %d)\n", t.first, t.second);
    
    vector<int> vals;
    int size = pos.size();
    vector<pair<int, int>> list;
    for (int i = 0; i < size; i++) {
        pair<int, int> tt = pos.front();
        pos.erase(pos.begin());
        //printf("selecting (%d, %d)\n", tt.first, tt.second);
        
        vector<pair<int, int>>::iterator it = find(list.begin(), list.end(), tt);
        if (it == list.end()) {
            //printf("selecting (%d, %d)\n", tt.first, tt.second);
            list.push_back(tt);
            
            t.first += tt.first;
            t.second += tt.second;
            
            if (t.first > t.second) {
                pos.push_back(t);
                
                vals.push_back(opt(pos, neg));
                
                pos.erase(pos.end());
            } else if (t.first < t.second) {
                neg.push_back(t);
                
                vals.push_back(opt(pos, neg));
                
                neg.erase(neg.end());
            } else {
                vals.push_back(opt(pos, neg) + t.first * t.second);
            }
            //cout << "OPT " << vals.back() << endl;
            
            t.first -= tt.first;
            t.second -= tt.second;
        }
        
        pos.push_back(tt);
    }
    
    neg.push_back(t);
    sort(vals.begin(), vals.end());
    return vals.front();
}


int main(int argc, char **argv) {
	const char *fn = "sample4.in";
	if (argc > 1)fn = argv[1];

	ifstream in(fn);
	int total_case;
	in >> total_case;

	for (int i = 1; i < total_case + 1; i++) {
        int n, ms, skills;
        in >> n;
        ms = n*n;
        skills = 0;
        bool *m = new bool[ms];
        
        char c;
        for (int i = 0; i < ms; i++) {
            in >> c;
            if (c == '0')m[i] = false;
            if (c == '1')m[i] = true;
            if (c == '1')skills++;
        }
        //printf("total skills %d\n", skills);
        
        unordered_set<int> pool;
        for (int i = 0; i < n; i++)pool.insert(i);
        vector<pair<int, int>> css;
        
        while (pool.size() > 0) {
            int elem = *(pool.begin());
                        
            unordered_set<int> comp;
            int ls = 0;
            
            pool.erase(elem);
            comp.insert(elem);
            unordered_set<int> ext;
            
            while (comp.size() > ls) {
                ls = comp.size();
                ext.clear();
                for (int e : comp) {
                    vector<int> mids = fromR(n, ms, m, e);
                    for (int mid : mids) {
                        ext.insert(mid);
                    }
                }
                
                unordered_set<int> closure;
                for (int e : pool) {
                    //cout << "checking " << e << ":";
                    
                    vector<int> mids = fromR(n, ms, m, e);
                    for (int mid : mids) {
                        vector<int> ids = fromC(n, ms, m, mid);
                        //cout << "from C" << mid << ":";
                        for (int id : ids) {
                            //cout << "find id" << id << ":";
                            closure.insert(id);
                        }
                    }
                }
                
                for (int id : closure) {
                    if (pool.count(id) > 0) {
                        vector<int> mids = fromR(n, ms, m, id);
                        for (int mid : mids) {
                            if (ext.count(mid) > 0) {
                                pool.erase(id);
                                comp.insert(id);
                            }
                        }                        
                    }
                }
            }
            
            css.push_back(pair<int, int>(ls, ext.size()));
            //cout << "Comp Size" << ls << ":";
            //cout << "Ext Size" << ext.size() << ":";
            
        }
        
        skills = -skills;
        vector<pair<int, int>> pos, neg;
        for (pair<int, int> p : css) {            
            //printf("comp (%d, %d)\n", p.first, p.second);
            if (p.first > p.second)pos.push_back(p);
            if (p.first < p.second)neg.push_back(p);
            if (p.first == p.second)skills += p.first * p.second;
        }
        
		cout << "Case #" << i << ": ";
        cout << opt(pos, neg) + skills;
        
		cout << endl;
	}

	return 0;
}