function [ result ] = is_prime1( number )
    result = 1;
    
    if number == 1
        result = 0; % 1 is not prime by definition
        return;
    end;
    
    %implement AKS test (based on fermat's principle) to check if the number is prime
    % see here: https://www.youtube.com/watch?v=HvMSRWTE2mI
    
    syms x
    polynomial = expand((x-1)^number - (x^number-1));   
    
    %if all coefficients of this polynomial in x are divisible by number then number is a prime!
    coefficients = coeffs(polynomial);  
    
    for i=1:size(coefficients, 2)
        if mod(coefficients(i), number) ~= 0
            result = 0;
            break;
        end
    end;
end

