clear all;
clc;
close all;

total = 0;
for i=1:576
    p = (i+1)^3 - i^3;
    if isprime(p)
        n = i^3;
        k = n^3 + n^2*p;
        fprintf('p = %.8i \t\t n = %.8i \t\t k = %i \n', p, n, k);
        total = total + 1;
    end;
end;

fprintf('Total numbers with the property is %i \n\n', total);