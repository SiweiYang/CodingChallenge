#include <iostream>
#include <fstream>
#include <string.h>
using namespace std;

int run(int *m, bool *v, int i) {
	if (v[i])return i;

	v[i] = true;
	return run(m, v, m[i]);
}

int count(bool *v, int s) {
	int total = 0;
	for (int i = 1; i < s + 1; i++) {
		if (v[i])total++;
	}
	return total;
}

int main(int argc, char **argv) {
	const char *fn = "sample3.in";
	if (argc > 1)fn = argv[1];

	ifstream in(fn);
	int total_case;
	in >> total_case;

	for (int i = 1; i < total_case + 1; i++) {
		int c_size;
		in >> c_size;

		int *m = new int[c_size + 1];
		for (int j = 0; j < c_size; j++) {
			in >> m[j+1];
		}

		int *mc = (int *)calloc(c_size + 1, sizeof(int));
		bool *v =  (bool *)calloc(c_size + 1, sizeof(bool));
		
		for (int j = 1; j < c_size + 1; j++) {
			v =  (bool *)calloc(c_size + 1, sizeof(bool));
			int end = run(m, v, j);
			if (m[m[end]] == end) {
				int c = count(v, c_size) - 1;
				if (c > mc[end])mc[end] = c;
			}
		}

		int max_c = 0;
		for (int j = 1; j < c_size + 1; j++) {
			max_c += mc[j];
		}

		for (int j = 1; j < c_size + 1; j++) {
			v =  (bool *)calloc(c_size + 1, sizeof(bool));
			int end = run(m, v, j);
			if (end != j) {
				continue;
			}

			int c = count(v, c_size);
			if (c > max_c)max_c = c;
		}

		cout << "Case #" << i << ": " << max_c << endl;
	}

	return 0;
}