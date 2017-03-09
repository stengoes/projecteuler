clear all;
clc;


target = 5000;

% Create all primes below target
numbers = primes(target);

% Dynamic programming
M = length(numbers);
N = sum(numbers)+1;

% Init memoization array
A = zeros(2, N, 'uint64');
A(1, 1) = 1;

stop = 1;
for j=1:M
    
    % Print progress
    if mod(j, 66) == 0
        fprintf('%d / %d \n', j, M);
    end
    
    for i=1:(stop+numbers(j))
        if i-numbers(j) > 0
            A(2, i) = mod(A(1, i) + A(1, i-numbers(j)), 10^16);
        else
            A(2, i) = A(1, i);
        end
    end;
    
    % Copy 2nd row to first and empty the 2nd row
    A(1, :) = A(2, :);
    A(2, :) = 0;
    
    % Store the stop index
    stop = stop+numbers(j);
end;
subsets = A(1, :);

% Select the subsets of which the sum is again prime
valid_subsets = subsets(isprime(0:sum(numbers)));

% Sum the number of those subsets modulo 10^16
answer = 0;
for i=1:length(valid_subsets)
    answer = mod(answer + valid_subsets(i), 10^16);
end;

% Print the answer
fprintf('The answer is: %d \n', answer);
answer