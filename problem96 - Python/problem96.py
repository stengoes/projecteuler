# Properties
N = 9
UNASSIGNED = 0


# Functions
def ReadoutFile(path):
    fr = open(path, 'r')
    text = fr.read()
    fr.close()

    return text


def InitGrids(text):

    grids = []

    index = -1
    y = 0
    for line in text.splitlines():
        if line[0:4] == 'Grid':
            grids.append([[0 for _ in range(N)] for _ in range(N)])
            index += 1
            y = 0
        else:
            for x in range(N):
                grids[index][y][x] = int(line[x])
            y += 1

    return grids

def InitGrids2(text):

    grids = []

    index = 0
    y = 0
    for line in text.splitlines():
        grids.append([[0 for _ in range(N)] for _ in range(N)])
        for i in range(len(line)):
            x = i % N;
            y = i // N;

            try:
                grids[index][y][x] = int(line[i])
            except:
                grids[index][y][x] = 0

        index += 1

    return grids

def PrintGrid(grid):

    # header
    print("+"+(("-"*7)+"+")*3)

    h = len(grid)
    for y in range(h):
        if y % 3 == 0 and y != 0:
            print("+" + (("-" * 7) + "+") * 3)

        line = "| "
        for x in range(len(grid[y])):
            if x % 3 == 0 and x != 0:
                line += "| "

            line += str(grid[y][x]) + " "
        line += "|"
        print(line)

    # footer
    print("+" + (("-" * 7) + "+") * 3)

    return


# Solving algorithm
def SolveSudoku(grid):

    [succes, row, col] = FindUnassignedLocation(grid)
    if not succes:
        return [True, grid]

    for num in range(1, N+1):

        if isSafe(grid, row, col, num):
            grid[row][col] = num

            [succes, grid] = SolveSudoku(grid)
            if succes:
                return [True, grid]

            grid[row][col] = UNASSIGNED

    return [False, grid]


def FindUnassignedLocation(grid):

    for row in range(N):
        for col in range(N):
            if grid[row][col] == UNASSIGNED:
                return [True, row, col]

    return [False, 0, 0]


def isSafe(grid, row, col, num):
    # Check if 'num' is not already placed in current row,
    # current column and current 3x3 box
    safe = not UsedInRow(grid, row, num) \
           and not UsedInCol(grid, col, num) \
           and not UsedInBox(grid, row - row%3 , col - col%3, num)

    return safe


def UsedInRow(grid, row, num):

    for x in range(N):
        if grid[row][x] == num:
            return True

    return False


def UsedInCol(grid, col, num):
    for y in range(N):
        if grid[y][col] == num:
            return True

    return False


def UsedInBox(grid, rowStart, colStart, num):
    for y in range(rowStart, rowStart+3):
        for x in range(colStart, colStart+3):
            if grid[y][x] == num:
                return True

    return False


# Main

# Readout file
path = 'sudokus.txt'
# path = 'hardsudokus.txt'
text = ReadoutFile(path)

# Decode grids
# initialGrids = InitGrids2(text) #harsudokus.txt
initialGrids = InitGrids(text)

'''
# Print grids
for i in range(len(initialGrids)):
    print("Grid "+str(i+1))
    PrintGrid(initialGrids[i])
'''

# Solve grids
answer = 0
index = 0
for grid in initialGrids:
    print("Try solving the initial grid "+str(index)+" :")
    PrintGrid(grid)
    [succes, solvedGrid] = SolveSudoku(grid)
    if succes:
        print("Solution is: ")
        PrintGrid(solvedGrid)
        answer += int(str(solvedGrid[0][0])+str(solvedGrid[0][1])+str(solvedGrid[0][2]))
    else:
        print("No solution exists for this grid!")

    index += 1

print("The answer is: "+str(answer))