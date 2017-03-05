import math

# user defined parameters
targetNumberOfDivisors = 500

# function to compute all factors of a number
def findAllFactors(number):
    factors = []
    for k in range(1, int(math.ceil(math.sqrt(number)))):
        if(number % k == 0):
            factors.append(k)
            factors.append(int(number / k))

    return factors


# main code
triangleNumber = 1
x = 2
while(True):

    # compute new triangle number
    triangleNumber = triangleNumber + x

    # compute all factors
    factors = findAllFactors(triangleNumber)

    # break out of the loop if number of factors is greater or equal to the target
    if(len(factors) >= targetNumberOfDivisors):
        break

    x += 1

# last triangle number is the answer
answer = triangleNumber

print('The answer is : ', answer)
#print(sorted(factors))