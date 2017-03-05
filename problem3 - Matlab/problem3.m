clear;

x = 600851475143;
priem = primes(x/10000);
answers = 1;
i=1;
j=1;

while prod(answers)~= x
    over = x/prod(answers);
    val = over/priem(i);
    if int64(val) == val;
        answers(j) = priem(i);        
        j = j+1;
    end
    
    i = i+1;
end;
