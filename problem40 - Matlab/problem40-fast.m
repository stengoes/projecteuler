clear all;
clc;

d = zeros(1, 7);
total = 0;
i = 1;
index = 1;
index2 = 1;
while total <= 1000000
    total = total + floor(log10(i))+1;
    
    if(total >= index2)
        temp = num2str(i);
        tempLength = size(temp, 2);
        d(index) = str2num(temp(tempLength-(total-index2)));
        
        index = index+1;
        index2 = index2*10;
    end;
    
    i = i + 1;
end;
answer = d(1) * d(2) * d(3) * d(4) * d(5) * d(6) * d(7)