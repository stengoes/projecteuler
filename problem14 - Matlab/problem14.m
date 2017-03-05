%check uneven or even 
clear

even=0;
uneven=0;
count = 0;

for xStart = 2:1000000
    x = xStart;
    count = 0;
    %collatz sequence
    while x ~= 1
        if mod(x,2) == 0;
            x = x/2;                      
        else
            x = 3*x+1;
        end
        count = count +1;
    end
    index(xStart) = count;
end

[maxValue, maxIndex] = max(index)