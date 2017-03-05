i = 1;
while 1
    for j = 11:20
        if mod(i,j) ~= 0
            break
        end              
    end    
    if j == 20;
        break;        
    end    
    i = i+1;
end

fprintf('The answer is: %i \n', i);