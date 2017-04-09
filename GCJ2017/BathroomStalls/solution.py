import click
import math

def find_depth(k, depth=0):
    if k < 2**depth:
        return depth
    return find_depth(k, depth + 1)

num = int(input())
for i in range(num):
    N, K = map(int, input().split())
    
    depth = find_depth(K) - 1
    # print(depth)
    occupied = 2**depth - 1
    # print(occupied)
    stall_left = N - occupied
    user_left = K - occupied
    size = stall_left // 2**depth
    # print(size)
    residule = stall_left - size * 2**depth
    # print(residule)
    if not user_left > residule:
        size += 1
    # print(size)
    # print('Case #{}: {} {}'.format(i + 1, math.ceil((size - 1) / 2), math.floor((size - 1) / 2)))
    if size % 2 == 1:
        print('Case #{}: {} {}'.format(i + 1, (size - 1) // 2, (size - 1) // 2))
    else:
        print('Case #{}: {} {}'.format(i + 1, (size - 1) // 2 + 1, (size - 1) // 2))