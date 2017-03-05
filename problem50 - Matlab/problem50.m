clc;
close all;
clear all;

target = 1000000;

%create lookuptable
if(exist('LUT', 'var') ~= 1)
    LUT = zeros(1, target);
    for i = 1:target
        LUT(i) = isprime(i);
    end;

    all_numbers = 1:target;
    primes = all_numbers(LUT == 1);
end;

totalRow = [];
for i=1:length(primes)        
    totalRow(length(totalRow)+1) = primes(i);
    if(sum(totalRow) >= target)
        break;
    end;
end;
N = length(totalRow);

% CONSECUTIVE PRIMES
start = 1;
stop  = N; 

cnt = 0;
row = totalRow(start:stop);
while (sum(row) > length(LUT) || ~LUT(sum(row)))
    len = N - cnt;
    start = 1;
    stop = start+len-1;
    row = totalRow(start:stop);
    while (sum(row) > length(LUT) || ~LUT(sum(row)))
        start = start+1;
        stop = start+len-1;
        
        if(stop > N)
            break;
        end;
        
        row = totalRow(start:stop);
    end;
    
    cnt = cnt + 1;
end;

maxLength = length(row)
maxNumber = sum(row)

% NOT CONSECUTIVE PRIMES% 
% row = totalRow;
%  
% cnt = 1;
% removeCnt = 0;
% while(sum(row) > length(LUT) || ~LUT(sum(row)))
%     
%     removeIndex = de2bi((cnt+removeCnt), N, 'left-msb');
%     row = totalRow(~logical(removeIndex));
%     
%     cnt = cnt * 2;
%     
%     if(cnt >= (2^length(totalRow)))        
%         removeCnt = removeCnt + 1;
%         cnt = 2^removeCnt;
%     end;
% end;
% 
% maxLength = sum(row ~= 0)
% maxNumber = sum(row)