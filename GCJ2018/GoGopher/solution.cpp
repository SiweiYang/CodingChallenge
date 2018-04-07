//
// Created by syang on 2017/4/22.
//
#include <algorithm>
#include <iostream>
#include <vector>

using namespace std;

bool is_filled(bool *board, int x, int y) {
    for (int i = x; i < x + 3; i++) {
        for (int j = y; j < y + 3; j++) {
            if (!board[i * 1000 + j]) {
                // printf("%d %d failed\n", i, j);
                return false;
            }
        }
    }

    return true;
}

void solve(int a) {
    bool *board = (bool *)calloc(1000*1000, sizeof(bool));

    int m = a / 3 + 1;
    int x, y;
    for (int k = 0; k < m;) {
        printf("%d %d\n", k + 2, 2);
        scanf("%d %d", &x, &y);
        if (x == 0 && y == 0)return;


        if (is_filled(board, k, 0)) {
            // printf("%d %d is filled\n", k, 2);
            k += 3;
        } else {
            // printf("%d %d\n", k + 1, 1);
            x -= 1;
            y -= 1;

            board[x * 1000 + y] = true;
        }
    }
}

int main() {
    setbuf(stdout, NULL);

    int T, A;
    scanf("%d", &T);
    // printf("got first\n");
    for (int i = 0; i < T; i++) {
        scanf("%d", &A);
        // printf("got second\n");
        solve(A);
    }
}
