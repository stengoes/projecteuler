clc;
close all;
clear all;

target = 5000;
%select all primes
all_primes = primes(target);
N = length(all_primes);

%test
% combinations1 = number_of_compositions_modulo(12, primes(20));  
% for i = 1:length(combinations1)
%     fprintf('M=%.2i \t possible: %i \n', (i-1), double(combinations1(i)));
% end;

combinations = number_of_compositions_modulo(sum(all_primes), all_primes);

numbers = 0:sum(all_primes);
prime_sums = isprime(numbers);
prime_sums_combinations = combinations(prime_sums);
totalForMod = 0;
totalFor = 0;
for i=1:length(prime_sums_combinations)
    totalFor = totalFor + prime_sums_combinations(i);
    totalForMod = mod( (mod(totalForMod, 10^16) + mod(prime_sums_combinations(i), 10^16)), 10^16);
end;


%alternative
totalSum = sum(mod(combinations(isprime(numbers)), 10^16));
totalSumMod = mod(totalSum, 10^16);

fprintf('for TOT # subsets = %.16i \n', totalFor);
fprintf('for MOD # subsets = %.16i \n', totalForMod);
fprintf('sum TOT # subsets = %.16i \n', totalSum);
fprintf('sum MOD # subsets = %.16i \n', totalSumMod);

