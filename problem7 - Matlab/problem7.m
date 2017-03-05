clear;

count = 0;
testgetal = 2;

while count < 10001 %al 10001 priem getallen gevonden?
    %antwoord nee
    
    %testen of testgetal priem is
     if is_prime3(testgetal) == 1
         count = count + 1;
     end
    
    %doorgaan naar volgende testgetal
    testgetal = testgetal + 1;
end

eindantwoord = testgetal - 1