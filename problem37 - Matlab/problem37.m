clear all;
clc;

guess = 1000000;
p = primes(guess);

counter = 1;
truncPrimes = zeros(1, 11);
for i = length(p):-1:1        
    string_p = num2str(p(i)); % is atleast 8 digits    
    
    trunc = 1;
    for j=1:length(string_p)
        if ~isprime(str2num(string_p(j:end))) || ~isprime(str2num(string_p(1:j)))
            trunc = 0;
            break;
        end;
    end;
    
    if trunc
        truncPrimes(counter) = p(i);
        counter = counter + 1;
    end;      
    
end;

resultPrimes = truncPrimes(truncPrimes > 10); 

answer = sum(resultPrimes);