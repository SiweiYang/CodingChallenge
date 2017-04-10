#include <iostream>
#include <vector>
using namespace std;

void find_positions(int N, vector<pair<int, int>> &positions) {
    if (positions.size() == N)return;

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            bool taken = false;
            for (pair<int, int> &p : positions) {
                if (i+1 == p.first)taken = true;
                if (j+1 == p.second)taken = true;
            }

            if (!taken) {
                    positions.emplace_back(i+1, j+1);
                    return find_positions(N, positions);
            }
        }
    }
};

int solve(int num) {
    int N, M;
    scanf("%d %d", &N, &M);
    vector<pair<int, int>> positions_1;
    vector<pair<int, int>> positions_2;
    for (int i = 0; i < M; i++) {
        char role;
        int r, c;
        scanf(" %c %d %d", &role, &r, &c);
        // printf("%c %d %d\n", role, r, c);
        if (role != '+')positions_1.emplace_back(r, c);
        if (role != 'o')positions_2.emplace_back(r, c);
    }

    int origin_size_1 = positions_1.size();
    find_positions(N, positions_1);
    // printf("size of positions_1: %d\n", positions_1.size());
    for (int i = origin_size_1; i < N; i++) {
        int r = positions_1[i].first;
        int c = positions_1[i].second;
        // printf("%c %d %d\n", "+", r, c);
    }

    printf("Case #%d:\n", num);
}

int main() {
    int num;
    scanf("%d", &num);
    for (int i = 0;i < num; i++)solve(i+1);
    return 0;
}