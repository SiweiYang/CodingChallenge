//
// Created by syang on 2017/4/22.
//
#include <algorithm>
#include <iostream>
#include <vector>

using namespace std;

vector<char> fill(char a, char b, char c, int x, int y, int z) {
    vector<char> result;
    for (int i = 0; i < z - x + y; i++) {
        result.push_back(a);
        result.push_back(b);
        result.push_back(c);
    }
    for (int i = 0; i < x - z; i++) {
        result.push_back(a);
        result.push_back(b);
    }
    for (int i = 0; i < x - y; i++) {
        result.push_back(a);
        result.push_back(c);
    }

    return result;
}

vector<char> solve(int n, int r, int o, int y, int g, int b, int v) {
//    printf("n = %d, r = %d, o = %d, y = %d, g = %d, b = %d, v = %d\n",
//           n, r, o, y, g, b, v
//    );
    if (o) {
        if (o == b && n == o + b)return fill('O', 'B', ' ', o, b, 0);
        if (n > o + b && o < b) {
            vector<char> result = solve(n - 2 * o, r, 0, y, g, b - o, v);
            for (int i = 0; i < result.size(); i++) {
                if (result[i] == 'B') {
                    for (int j = 0; j < o; j++) {
                        result.insert(result.begin() + i, 'O');
                        result.insert(result.begin() + i, 'B');
                    }
                    return result;
                }
            }
        }
        return vector<char>();
    }
    if (g) {
        if (g == r && n == g + r)return fill('G', 'R', ' ', g, r, 0);
        if (n > g + r && g < r) {
            vector<char> result = solve(n - 2 * g, r - g, o, y, 0, b, v);
            for (int i = 0; i < result.size(); i++) {
                if (result[i] == 'R') {
                    for (int j = 0; j < g; j++) {
                        result.insert(result.begin() + i, 'G');
                        result.insert(result.begin() + i, 'R');
                    }
                    return result;
                }
            }
        }
        return vector<char>();
    }
    if (v) {
        if (v == y && n == v + y)return fill('V', 'Y', ' ', v, y, 0);
        if (n > v + y && v < y) {
            vector<char> result = solve(n - 2 * v, r, o, y - v, g, b, 0);
            for (int i = 0; i < result.size(); i++) {
                if (result[i] == 'Y') {
                    for (int j = 0; j < v; j++) {
                        result.insert(result.begin() + i, 'V');
                        result.insert(result.begin() + i, 'Y');
                    }
                    return result;
                }
            }
        }
        return vector<char>();
    }

    vector<pair<int, char>> list = {{r, 'R'}, {y, 'Y'}, {b, 'B'}};
    sort(list.begin(), list.end());
    if (n == 1)return vector<char>({list[2].second});
    if (list[2].first > list[0].first + list[1].first)return vector<char>();

    return fill(list[2].second, list[1].second, list[0].second, list[2].first, list[1].first, list[0].first);
}

int main() {
    int T, N;
    scanf("%d", &T);
    for (int i = 0; i < T; i++) {
        int n, r, o, y, g, b, v;
        scanf("%d %d %d %d %d %d %d", &n, &r, &o, &y, &g, &b, &v);
        vector<char> result = solve(n, r, o, y, g, b, v);
        if (result.size()) {
            printf("Case #%d: ", i + 1);
            for (char c : result) {
                printf("%c", c);
            }
            printf("\n");
        } else {
            printf("Case #%d: IMPOSSIBLE\n", i + 1);
        }
    }
}
