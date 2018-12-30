#include <iostream>

#define LENGTH 10000  // length of number

void print_array(int* number, int* n)
{
    for(int i = *n-1; i >= 0; i--)
        std::cout << number[i];
    std::cout << std::endl;
}

int digit_sum(int* number, int n)
{
    /* Sums all digits in the array `number` with length `n` */
    int sum = 0;
    while(n-- >= 0)
        sum += number[n];
    return sum;
}

void multiply_by_digit(int* number, int* n, int digit)
{
    int carry = 0;
    for(int i = 0; i < *n; i++)
    {
        int tmp = (number[i] * digit + carry);
        number[i] = (tmp % 10);
        carry = (tmp - number[i]) / 10;
    }
    if(carry != 0)
    {
        number[*n] = carry;
        *n = *n + 1;
    }
}

void add(int* number1, int* n1, int* number2, int* n2)
{
    /* Adds the arrays `number1` and `number2` and stores the result in `number1` and `n1` */
    int carry = 0;
    int n = (*n1 >= *n2) ? *n1 : *n2;
    for(int i = 0; i < n; i++)
    {   
        int tmp = (number1[i] + number2[i] + carry);
        number1[i] = (tmp % 10);
        carry = (tmp - number1[i]) / 10;
    }
    *n1 = n;
    if(carry != 0)
    {
        number1[*n1] = carry;
        *n1 = *n1 + 1;
    }
}

void append_zero(int* number, int* n)
{
    int t = *n;
    while(t >= 0)
    {
        number[t] = number[t-1];
        t--;
    }
    number[0] = 0;
    *n = *n + 1;
}

void multiply(int *number1, int* n1, int *number2, int* n2)
{
    /* Multiplies the arrays `number1` and `number2` and stores the result in `number1` and `n1` */
    
    // Store intermediate result in a temp variable
    int result[LENGTH] = {0};
    int result_n = 0;
    for(int i = 0; i < *n2; i++)
    { 
        // Make copy of number1
        int temp[LENGTH] = {0};
        memcpy(temp, number1, *n1*sizeof(int));
        int temp_n = *n1;

        // Multiply copy with a single digit and add to intermediate result
        multiply_by_digit(temp, &temp_n, number2[i]);
        add(result, &result_n, temp, &temp_n);

        // Append a zero to number1 
        append_zero(number1, n1);
    }

    // Copy result back to number1
    memcpy(number1, result, result_n*sizeof(int));
    *n1 = result_n;
}

void increment_one(int* number, int* n)
{
    /* Increments the array `number` inplace by 1 */
    int carry = 1;
    for(int i = 0; i < *n; i++)
    {
        if(carry == 0)
            break;

        // Compute 
        int tmp = number[i] + carry;

        // Take only the last digit and carry the other
        number[i] = (tmp % 10);
        carry = (tmp - number[i]) / 10;
    }
    if(carry != 0)
    {
        number[*n] = carry;
        *n = *n + 1;
    }
}

int digit_sum_factorial(int n)
{
    // Compute n! and store each digit in the array called `number1`
    int number1[LENGTH];

    // Start with 1
    number1[0] = 1;
    int n1 = 1;  

    // Use number2 as temp counter
    int number2[10];
    number2[0] = 1;
    int n2 = 1;

    // Recursively multiply `number1` with `number2` and then increment `number2` by one
    int i = 1;
    while(i <= n)
    {   
        multiply(number1, &n1, number2, &n2);
        increment_one(number2, &n2);
        i++;
    }

    // Compute digit sum
    int sum = digit_sum(number1, n1);

    // Return answer
    return sum;
}

int main()
{
    // Test case
    std::cout << "The digit sum of 10! = " << digit_sum_factorial(10) << std::endl; 
    assert(digit_sum_factorial(10) == 27); // answer should be 27

    // Real problem
    std::cout << "The digit sum of 100! = " << digit_sum_factorial(100) << std::endl; 
    assert(digit_sum_factorial(100) == 648); // answer should be 648

    return 0;
}
