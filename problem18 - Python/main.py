import numpy as np

INPUT_TEST = """
3
7 4
2 4 6
8 5 9 3
"""
# Answer of this example is:
# path=[3, 7, 4, 9], sum=23

INPUT = """
75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
"""
# Answer of this example is:
# path=[75, 64, 82, 87, 82, 75, 73, 28, 83, 32, 91, 78, 58, 73, 93], sum=1074

def parse_pyramid(text):

    # Remove excess whitespaces
    text = text.strip()

    # Parse the pyramid
    lines = text.split("\n")
    pyramid = [[int(number) for number in line.split(' ')] for line in lines]

    return pyramid

def print_pyramid(pyramid):
    pass

def print_pyramid_and_path(pyramid, path):
    pass

def find_maximum_sum_path(pyramid):

    # Get height of the pyramid
    height = len(pyramid)

    # Use dynamic programming to find the maximum sum
    A = [pyramid[0]]
    for y in range(1, height):
        A.append(list())
        width = y+1
        for x in range(width):
            left_path = A[y-1][x] if x < y else -np.inf
            right_path = A[y-1][x-1] if x-1 < y else -np.inf
            best = max(left_path, right_path)
            A[y].append(pyramid[y][x] + best)

    # The maximum sum is the largest element in the bottom row of the memoization array
    # print("sum: {}".format(max(A[height-1])))

    # Reconstruct the path from the memoization array from bottom to top
    path = list()
    ymax = height-1
    xmax = np.argmax(A[height-1])
    path.append(pyramid[height-1][xmax])
    for ymax in range(height-2, -1, -1):
        left_path = A[ymax][xmax] if xmax <= ymax else -np.inf
        right_path = A[ymax][xmax-1] if xmax-1 >= 0 else -np.inf
        if right_path > left_path:
            xmax = xmax-1
        path.append(pyramid[ymax][xmax])

    # Reverse the path from bottom-top to top-bottom
    path.reverse()

    return path, sum(path)

if __name__ == "__main__":
    pyramid = parse_pyramid(INPUT)
    path, sum = find_maximum_sum_path(pyramid)
    print("The answer is: {}".format(sum))
