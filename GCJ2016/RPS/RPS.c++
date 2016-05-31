#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <unordered_map>
#include <string.h>
using namespace std;

void trans(int *vals) {
    int r, p, s;
    r = vals[1];
    p = vals[2];
    s = vals[0];

    vals[0] += r;
    vals[1] += p;
    vals[2] += s;
}

void swap(int pos, int step, char *s) {
    char t;
    for(int i=0; i<step; i++) {
        t = s[pos+i];
        s[pos+i] = s[pos+i+step];
        s[pos+i+step] = t;
    }
}

bool gt(int length, char *p, int pp, char *q, int pq) {
    for (int i=0; i<length; i++) {
        if(p[pp+i] > q[pq+i]){
            return true;
        }
        
        if(p[pp+i] < q[pq+i]){
            return false;
        }
    }
    
    return false;
}

int tomin(int n, int i, char *s) {
    int step = pow(2,i);

    for (int j=0; j<n; j+=2*step) {
        if(gt(step, s, j, s, j + step)) {
            swap(j, step, s);
        }
    }
}

void gen(int n, char *s) {
    if(n == 0)return;

    for (int i=n-1; i>-1; i--) {
        //ss[2*i] = s[i];
        //ss[2*i + 1] = s[i];
        char p, q;
        if (s[i] == 'R') {
            p = 'R';
            q = 'S';
        }
    
        if (s[i] == 'P') {
            p = 'P';
            q = 'R';
        }
    
        if (s[i] == 'S') {
            p = 'P';
            q = 'S';
        }
        
        s[2*i] = p;
        s[2*i + 1] = q;
    }
}

int main(int argc, char **argv) {
    const char *fn = "sample1.in";
    if (argc > 1)fn = argv[1];

    ifstream in(fn);
    int total_case;
    in >> total_case;
    
    int vals[3];
    for (int i = 1; i < total_case + 1; i++) {
        int n, r, p, s, length;
        in >> n;
        in >> r;
        in >> p;
        in >> s;
        length = pow(2, n);

        char *cand = NULL;
        char c;
        for (int i = 0; i < 3; i++) {
            if (i==0) {
                c = 'R';
            }
            if (i==1) {
                c = 'P';
            }
            if (i==2) {
                c = 'S';
            }
            
            vals[i%3] = 1;
            vals[(i+1)%3] = 0;
            vals[(i+2)%3] = 0;
 
            for(int j=0; j < n; j++) {
                trans(vals);
            }
            
            if (vals[0] == r && vals[1] == p && vals[2] == s) {
                char *str = (char *)calloc(length, sizeof(char));
                *str = c;
                
                for(int j=0; j<n; j++) {
                    gen(pow(2, j), str);
                }

                for(int j=0; j<n; j++) {
                    tomin(length, j, str);
                }

                if(cand == NULL || gt(length, cand, 0, str, 0))cand = str;
            }
        }

        cout << "Case #" << i << ": ";
        if (cand == NULL) {
            cout << "IMPOSSIBLE";
        } else {
            cout << cand;
        }
        cout << endl;
    }

    return 0;
}