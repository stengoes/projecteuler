x = 1:999;
answer = sum(x(mod(x,3) == 0 | mod(x,5) == 0))
