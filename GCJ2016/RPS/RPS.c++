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

int tomin(int n, int i, char *s) {
    int step = pow(2,i);

    for (int j=0; j<n; j+=2*step) {
        bool ts = false;
        for (int k=0; k<step; k++) {
	    if(s[j+k] > s[j+k+step]){
	        ts = true;
		break;
	    }
	}

        if(ts) {
	    swap(j, step, s);
	}
    }
}

char * gen(int n, char *s) {
    if(n == 0)return s;

    char *ss = new char[n*2];

    for (int i=0; i<n; i++) {
        //ss[2*i] = s[i];
	//ss[2*i + 1] = s[i];

	if (s[i] == 'R') {
	    ss[2*i] = 'R';
	    ss[2*i + 1] = 'S';
	}

	if (s[i] == 'P') {
	    ss[2*i] = 'P';
	    ss[2*i + 1] = 'R';
	}

	if (s[i] == 'S') {
	    ss[2*i] = 'P';
	    ss[2*i + 1] = 'S';
	}
    }

    return ss;
}

int main(int argc, char **argv) {
	const char *fn = "sample1.in";
	if (argc > 1)fn = argv[1];

	ifstream in(fn);
	int total_case;
	in >> total_case;
	
        int vals[3];
	for (int i = 1; i < total_case + 1; i++) {
	        int n, r, p, s;
		in >> n;
		in >> r;
		in >> p;
		in >> s;
                
		char c;
		char *str;
		for (int i = 0; i < 3; i++) {
		    if (i==0) {
		    c = 'P';
		    vals[i%3] = 0;
	            vals[(i+1)%3] = 1;
		    vals[(i+2)%3] = 0;
		    }
		    if (i==1) {
		    c = 'R';
		    vals[i%3] = 0;
	            vals[(i+1)%3] = 0;
		    vals[(i+2)%3] = 1;
		    }
		    if (i==2) {
		    c = 'S';
		    vals[i%3] = 1;
	            vals[(i+1)%3] = 0;
		    vals[(i+2)%3] = 0;
		    }

	            
                    
		    for(int j=0; j < n; j++) {
		        trans(vals);
		    }

		    if (vals[0] == r && vals[1] == p && vals[2] == s) {
		        str = &c;
		        for(int j=0; j<n; j++) {
			    str = gen(2^j, str);
			}

			for(int j=0; j<n; j++) {
			    tomin(n, j, str);
			}

		        break;
		    }
		    c = 'N';
		}

		cout << "Case #" << i << ": ";
		if (c == 'N') {
		    cout << "IMPOSSIBLE";
		} else {
		    cout << str;
		}
		cout << endl;
	}

	return 0;
}