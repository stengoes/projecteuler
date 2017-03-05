function [ result ] = is_prime3( number )
  result = 1;
  if number <= 3
      result = (number > 1);
      return;
  end
  if mod(number, 2) == 0 || mod(number, 3) == 0 
      result = 0;
      return;
  end
  i = 5;
  while(i*i <= number)
    if mod(number,i) == 0 || mod(number, (i + 2)) == 0
      result = 0;
      return;
    end
    i = i + 6;
  end
  return;
end

