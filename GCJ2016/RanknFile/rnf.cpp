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
		int sm;
		in >> sm;

		int count = 0;
		unordered_map<int, int> dict;
		while (count < sm * (2 * sm - 1)) {
			int h;
			in >> h;

			if (dict.count(h) == 0) {
				dict[h] = 1;
			} else {
				dict[h] = dict[h] + 1;
			}
			count++;
		}

		vector<int> v;
		for(pair<int, int> kv : dict) {
		    if (kv.second % 2 == 1)v.push_back(kv.first);
		}
		sort(v.begin(), v.end());

		cout << "Case #" << i << ":";
		pr(v);
		cout << endl;
	}

	return 0;
}