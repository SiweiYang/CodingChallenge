#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <unordered_map>
#include <string.h>
using namespace std;
 
void eval(int n, double *vals, double p) {
        double *a = new double[n];
        double *b = new double[n];

	for (int i = 0; i < n; i++) {
	    a[i] = vals[i] * (1 - p);
	}

	for (int i = 1; i < n; i++) {
	    b[i] = vals[i-1] * p;
	}

        for (int i = 0; i < n; i++) {
	    vals[i] = a[i] + b[i];
	}
}

int main(int argc, char **argv) {
	const char *fn = "sample2.in";
	if (argc > 1)fn = argv[1];

	ifstream in(fn);
	int total_case;
	in >> total_case;

	for (int i = 1; i < total_case + 1; i++) {
	        int n, k;
		in >> n;
		in >> k;
                double * rvals = new double[n];
		for (int i = 0; i < n; i++) {
		    in >> rvals[i];
		}

		sort(rvals, rvals + n);
		double * vals = new double[k];
		double * ps = new double[k + 1];
                
		double p = 0;
                for (int i = 0; i < k + 1; i++) {
		    ps[0] = 1;
		    for (int j = 0; j < i; j++) {
        		    vals[j] = rvals[j];
			    ps[j+1] = 0;
		    }

		    for (int j = i; j < k; j++) {
        		    vals[j] = rvals[n - k + j];
			    ps[j+1] = 0;
		    }

		    for (int j = 0; j < k; j++) {
        		    eval(k+1, ps, vals[j]);
		    }

		    if (ps[k/2] > p)p = ps[k/2];
		}

		cout << "Case #" << i << ": ";
		cout << p;
		cout << endl;
	}

	return 0;
}