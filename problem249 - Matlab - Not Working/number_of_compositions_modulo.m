function [ answer ] = number_of_compositions_modulo( M, S )
    S = [0 S];
    M = M + 1;
    N = length(S);
       
    combinations = zeros(2, M, 'uint64'); % initialising to 0    
    for i=1:2
        combinations(i,1) = 1;
    end;
    
    m = 0;
    for i=2:N
        for j = 1:M
            if(combinations(i-1-m,j) > 0)
                combinations(i-m,j) = combinations(i-1-m,j);
            end;
            if j-S(i) >= 1 && combinations(i-1-m,j-S(i)) > 0
                combinations(i-m,j) = mod(mod(combinations(i-m,j),10^16) + mod(combinations(i-m-1,j-S(i)), 10^16) ,10^16);
            end;      
        end;
        
        if i ~= N
            combinations(1, :) = combinations(2, :); %copy the second row to the first
            combinations(2, :) = 0;
            combinations(2, 1) = 1;
            m = m + 1;
        end;
        
        if mod(i,10) == 0
            fprintf('%i \n', i);
        end;
    end;      
    
    fprintf('%i \n', N);
    
    answer = combinations(end, :);
end

