#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <unordered_map>
#include <string.h>
using namespace std;

void pr(vector<int> v) {
	for (auto i : v) {
		cout << " " << i;
	}
}

int main(int argc, char **argv) {
	const char *fn = "sample2.in";
	if (argc > 1)fn = argv[1];

	ifstream in(fn);
	int total_case;
	in >> total_case;

	for (int i = 1; i < total_case + 1; i++) {
		cout << "Case #" << i << ":";
		cout << endl;
	}

	return 0;
}