def factorial(x):
    if x == 0:
	return 1
    else:
    	return x * factorial(x-1)

def nchoosek(n, k):
    return factorial(n) / (factorial(n-k)*factorial(k)) 

if __name__== "__main__":
    N = int(raw_input("Please enter grid size: "))

    # The correct answer is an entry in Pascals triangle
    # corresponding to row: 2*N and column: N.
    answer = nchoosek(2*N, N)
    print("The answer is: {}".format(answer))
