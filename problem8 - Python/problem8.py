# user defined parameters
inputFile = 'matrix.txt'
numAdjacentDigits = 13

# read input file
fr = open(inputFile, 'r')
text = fr.read()
fr.close()

# remove the new lines
text = text.replace('\n', '')

# run over the text and find answer product
answer = 0
numbers = []
for i in range(len(text)-numAdjacentDigits):
    product = 1
    currentNumbers = []
    for j in range(numAdjacentDigits):
        product *= int(text[i+j])
        currentNumbers.append(int(text[i+j]))

    if product > answer:
        answer = product
        numbers = currentNumbers

# create nice output
s = '';
for i in range(len(numbers)):
    s += str(numbers[i])
    if i != len(numbers)-1:
        s += ' * '
s += ' = ' + str(answer)

# print the answer
print(s)