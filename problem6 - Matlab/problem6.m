square = 0;
sum=0;

for i=1:100
    square = square + i^2;
    sum = sum + i;
end

square_sum = sum^2;

antwoord = abs(square - square_sum)
clear all; 
answer_sten = sum(1:100).^2 - sum((1:100).^2)