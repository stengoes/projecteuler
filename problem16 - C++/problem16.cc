#include <iostream>
#include <math.h>

int sum_array(int* number, int num_digits)
{
    /* This functions sums all integers in the array `number` with length `num_digits` */
    int sum = 0;
    while(num_digits-- >= 0)
        sum += number[num_digits];
    return sum;
}

int digit_sum_base2(int n)
{
    // Compute the number of digits in the number: 2^n
    // int num_digits = floor(n*log10(2)) + 1;

    // Compute 2^n and store each digit in the array called `number`
    int* number = new int[1000]();

    // Start with 1
    number[0] = 1;
    int num_digits = 1;  

    // Recursively multiply `number` by 2 (n times)
    int exponent = 1;
    while(exponent++ <= n)
    {   
        int carry = 0;
        for(int i = 0; i < num_digits; i++)
        {
            int tmp = (number[i] * 2 + carry);
            number[i] = (tmp % 10);
            carry = (tmp - number[i]) / 10;
        }
        if(carry != 0)
            number[num_digits++] = carry;
    }

    // Compute digit sum of `number`
    int sum = sum_array(number, num_digits);

    // Free allocated memory 
    delete[] number;

    // Return answer
    return sum;
}

int main(){
    //std::cout << "The digit sum of 2^15 = " << digit_sum_base2(15) << std::endl; // answer should be 26
    std::cout << "The digit sum of 2^1000 = " << digit_sum_base2(1000) << std::endl; // answer should be 1366
}