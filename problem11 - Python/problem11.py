
# user defined parameters
adjacentNumbers = 4

# load file
path = 'matrix.txt'
fr = open(path, 'r')
text = fr.read()
fr.close()

# split lines
lines = text.splitlines()

# fill matrix
matrix = []
height = len(lines)
width = len(lines[0].split(' '))
matrix = [[0 for _ in range(width)] for _ in range(height)]
for y in range(height):
    numbers = lines[y].split(' ')
    for x in range(width):
        matrix[y][x] = int(numbers[x])

# compute answer
answer = 0
numbers = []

# horizontally
for y in range(height):
    for x in range(width-adjacentNumbers):
        product = matrix[y][x] * matrix[y][x + 1] * matrix[y][x + 2] * matrix[y][x + 3]
        if(product > answer):
            answer = product
            numbers = [matrix[y][x], matrix[y][x + 1], matrix[y][x + 2], matrix[y][x + 3]]

# vertically
for y in range(height - adjacentNumbers):
    for x in range(width):
        product = matrix[y][x] * matrix[y + 1][x] * matrix[y + 2][x] * matrix[y + 3][x]
        if (product > answer):
            answer = product
            numbers = [matrix[y][x], matrix[y + 1][x], matrix[y + 2][x], matrix[y + 3][x]]

# diagonally
for y in range(height-adjacentNumbers):
    for x in range(width-adjacentNumbers):
        product = matrix[y][x] * matrix[y+1][x+1] * matrix[y+2][x+2] * matrix[y+3][x+3]
        if (product > answer):
            answer = product
            numbers = [matrix[y][x], matrix[y+1][x+1], matrix[y+2][x+2], matrix[y+3][x+3]]

# diagonally
for y in range(height-adjacentNumbers):
    for x in range(adjacentNumbers, width):
        product = matrix[y][x] * matrix[y+1][x-1] * matrix[y+2][x-2] * matrix[y+3][x-3]
        if (product > answer):
            answer = product
            numbers = [matrix[y][x], matrix[y+1][x-1], matrix[y+2][x-2], matrix[y+3][x-3]]

print('The answer is: ', answer)
print(numbers)