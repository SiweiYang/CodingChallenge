#include <iostream>
#include <fstream>
#include <string>
using namespace std;

long long eval(int n, int *s, int base) {
  long long total = 0;
  //cout << "num " << n << " b " << base << endl;
  for (int i = 0; i < n; i++) {
    total = total * base + s[i];
    //cout << "total " << total << " with " << s[i] << endl;
  }
  
  return total;
}

int main(int argc, const char* argv[]) {
  const char *f = "sample.in";
  if (argc > 1)f = argv[1];

  ifstream file(f);
  int nc;
  file >> nc;
  //printf(" Case = %d\n", nc);
  
  for (int i = 1; i <= nc; i++) {
    int k, c, s;
    file >> k >> c >> s;
    int *a = new int[c];
    //printf(" K = %d, C = %d, S = %d\n", k, c, s);
    
    printf("Case #%d:", i);
    if ( k > c * s) {
      printf(" IMPOSSIBLE\n");
    } else {
      int cur = k - 1;
      
      while (cur > -1) {
        for (int j = 0; j < c; j++) {
          a[j] = cur - j;
          //cout << "choose " << cur - j << endl;
        }
        
        if (cur < c) {
          printf(" %lld", 1 + eval(cur + 1, a, k));        
        } else {
          printf(" %lld", 1 + eval(c, a, k));
        }
        
        cur -= c;
      }
      
      cout << endl;
    }
  }
  return 0;
}
