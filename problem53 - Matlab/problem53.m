clear all;
clc; 
close all;

target = 100;
total = 0;

for n = 1:target
     for r = 1:n
        temp = nchoosek(n, r);
        if temp > 1000000
            total = total + 1;
        end;    
    end;
end;

total