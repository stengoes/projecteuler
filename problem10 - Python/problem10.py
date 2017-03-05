import math

def generatePrimes(n):
    # implementation of 'de Zeef van Eratosthenes'
    # https://nl.wikipedia.org/wiki/Zeef_van_Eratosthenes

    p = [True for i in range(n)]

    # 1 is not prime by definition
    p[0] = False

    for k in range(math.ceil(math.sqrt(n))):
        if p[k]:
            for j in range((k+1) ** 2 - 1, n, k+1):
                p[j] = False

    indices = [i for i, x in enumerate(p) if x]

    primes = []
    for i in range(len(indices)):
        primes.append(indices[i]+1)

    return primes

# User-defined parameters
N = 2 * 10 ** 6

# Generate all primes below N
primes = generatePrimes(N)

# Calculate the sum
answer = sum(primes)

# Print the answer
print(answer)