clear all;
clc;

% a + b + c = p
% a*a + b*b = c*c

amount_solutions = zeros(1, 1000);

for p = 1:1000    
    for a = 1:p
        for b = 1:p-a
            c = p-a-b;
            if ((a^2 + b^2) == c^2)
                amount_solutions(p) = amount_solutions(p) + 1;
            end;
        end;
    end;    
end

[maxValue, maxIndex] = max(amount_solutions);
maxIndex
maxValue