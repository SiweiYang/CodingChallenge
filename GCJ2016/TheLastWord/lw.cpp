#include <iostream>
#include <fstream>
#include <string.h>
using namespace std;

void shift(char *s, int l) {
	for (int i = l-1; i > 0; i--) {
		s[i] = s[i-1];
	}
}

void smallest(char *s, int l) {
	if (l < 2)return;

    smallest(s, l - 1);
    
    bool to_shift = false;

    if (s[0] > s[l-1])return;
    if (s[0] < s[l-1])to_shift = true;
    
    for (int i = 0; i < l && !to_shift; i++) {
    	if (s[i+1] > s[i])return;
    	if (s[i+1] < s[i]) {
    		to_shift = true;
    	}
    }

    char c = s[l-1];
    if (to_shift)shift(s, l);
    s[0] = c;
}

int main(int argc, char **argv) {
	const char *fn = "sample1.in";
	if (argc > 1)fn = argv[1];

	ifstream in(fn);
	int total_case;
	in >> total_case;

	for (int i = 1; i < total_case + 1; i++) {
		string s;
		in >> s;
		cout << "Case #" << i << ": ";
		char *sp = strdup(s.c_str());
		smallest(sp, s.length());
		cout << sp << endl;
	}

	//char *s = new char[3];
	//s[0] = 'J';
	//s[1] = 'A';
	//s[2] = 'M';
	//smallest(s, 3);
	//shift(s, 3);
	//cout << s << endl;

	return 0;
}