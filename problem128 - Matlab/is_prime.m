function [ result ] = is_prime( number )

    if(number < 1000)
        result = is_prime3(number);
    else
        result = is_prime4(number);
    end;
        
    return;
end

