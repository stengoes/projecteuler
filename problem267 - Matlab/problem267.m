clear all;
clc;
close all;

N = 1000;
H = 0:N;
T = zeros(1, length(H));
T0 = 1;
target = 10^9;

f_space = linspace(0, 1, 1000);  %linspace(0.1, 0.2, 1000);
probabilities = zeros(1, length(f_space));
for j = 1:length(f_space)
    f = f_space(j); 
    for i = 1:length(H);
        T(i) = T0 * (1-f)^(N-H(i))*(1+2*f)^H(i); 
    end;

    logPDF = zeros(1, length(H));
    for i = 1:length(H);
        logPDF(i) = gammaln(N+1) - ( gammaln(H(i)+1) + gammaln(N-H(i)+1) );    
    end;
    maxValue = max(logPDF);
    logPDF = logPDF - maxValue;
    pdf = exp(logPDF) / sum(exp(logPDF));
  
    for i =1:length(pdf);
        if(T(i) >= target)
            probabilities(j) = probabilities(j) + pdf(i);
        end;
    end;
end;

figure();
plot(f_space, probabilities);

%zoom in on the interval with the maximum
f_space = linspace(0.1, 0.2, 1000);
probabilities = zeros(1, length(f_space));
for j = 1:length(f_space)
    f = f_space(j); 
    for i = 1:length(H);
        T(i) = T0 * (1-f)^(N-H(i))*(1+2*f)^H(i); 
    end;

    logPDF = zeros(1, length(H));
    for i = 1:length(H);
        logPDF(i) = gammaln(N+1) - ( gammaln(H(i)+1) + gammaln(N-H(i)+1) );    
    end;
    maxValue = max(logPDF);
    logPDF = logPDF - maxValue;
    pdf = exp(logPDF) / sum(exp(logPDF));
  
    for i =1:length(pdf);
        if(T(i) >= target)
            probabilities(j) = probabilities(j) + pdf(i);
        end;
    end;
end;

figure();
plot(f_space, probabilities);

[answer, index] = max(probabilities);
fprintf('The probability is %.12f \n', answer);