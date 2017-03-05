function [ result ] = is_prime2( number )
    result = 1;
    
    if number == 1
        result = 0; %1 is prime by definition
        return;
    end;
    
    for i = 2:(number-1)
        if mod(number, i) == 0
            result = 0;
            return;
        end;
    end;
end




