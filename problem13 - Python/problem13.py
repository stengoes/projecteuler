import math

# readout numbers from file
path = 'numbers.txt'
fr = open(path, 'r')
text = fr.read()
fr.close()
numbers = text.splitlines()

# sum the numbers
N = len(numbers)
sum = 0
for i in range(N):
    sum += int(numbers[i])
print(sum)

# get the first 10 digits
answer = str(sum)[0:10]
print(answer)
