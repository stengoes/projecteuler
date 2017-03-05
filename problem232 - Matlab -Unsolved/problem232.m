clc;
clear all;

repetition = 1000000;
winner1 = 0;
winner2 = 0;
for i=1:repetition
    isWinner = 0;
    counter = 0;    
    while ~isWinner
        toss = randi([0, 1]);    
        if toss == 1
           isWinner = 1; 
           break;
        end;
        counter = counter + 1;
    end;

    if mod(counter, 2) == 0
        winner1 = winner1 + 1;
        %fprintf('Winner is player 1\n');
    else    
        winner2 = winner2 + 1;
        %fprintf('Winner is player 2\n');
    end;
end;

fprintf('Winner 1 probabiblity: %.6f \n', (winner1 / repetition));