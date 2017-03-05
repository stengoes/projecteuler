clear all;
clc;
close all;

%create pdf for six sided dice
N6 = 6;
dice6 = [1 1 1 1 1 1];
pdf6 = dice6;
for i=1:(N6-1)
    pdf6 = conv(pdf6, dice6);
end;
results6 = N6*1:N6*6;
pdf6Normalized = pdf6 / sum(pdf6);

%create pdf for four sided dice
N4 = 9;
dice4 = [1 1 1 1];
pdf4 = dice4;
for i=1:(N4-1)
    pdf4 = conv(pdf4, dice4);
end;
results4 = N4*1:N4*4;
pdf4Normalized = pdf4 / sum(pdf4);

%plot the pdfs
figure();
title('PDF 6 x 6-sided dices vs PDF 9 x 4-sided dices');
plot(results6, pdf6Normalized, results4, pdf4Normalized);
xlabel('Total amount');
ylabel('Probability');
legend('6x 6-sided dice', '4x 4-sided dice');

%compare both pdfs compute the chance that 9x 4-sided wins
% mu6 = 0;
% for i=1:length(results6)
%     mu6 = mu6 + results6(i) * pdf6Normalized(i);
% end;
% 
% mu4 = 0;
% for i=1:length(results4)
%     mu4 = mu4 + results4(i) * pdf4Normalized(i);
% end;

%compute bayes rule for all possible scenarios
conditionalChance = zeros(1, length(results4));
chance4Win = zeros(1, length(results4));
for i=1:length(results4) 
    for j=1:length(results6)
        if results6(j) < results4(i)
             conditionalChance(i) = conditionalChance(i) + pdf6Normalized(j);
        end;
    end;    
    chance4Win(i) = conditionalChance(i) * pdf4Normalized(i);
end;
answer = sum(chance4Win);
fprintf('The answer = %.8f\n', answer);

%Monte carlo 
d = 7;
N = (1.96).^2*10.^(2.*d);

N = 10^8;

counter = 0;
for i=1:N
    person1 = sum(randi([1,6], 1, 6));
    person2 = sum(randi([1,4], 1, 9));
    if(person2 > person1)
        counter = counter + 1;
    end;
end;

answer = counter / N;
fprintf('The answer = %.8f\n', answer);
