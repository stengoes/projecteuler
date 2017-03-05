clear

% initial values
x(1) = 1;
x(2) = 2;

i=3;
while (x(end)+x(end-1)) <= 4000000 
    x(i) = x(i-1) + x(i-2);    
    i=i+1;    
end

even = 0;
for j=1:length(x)
    if mod(x(j),2) == 0 % check for even number
        even = even + x(j);
    end
end

