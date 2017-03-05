clear all;

x = 999:-1:1;
y = 999:-1:1;
answer = 0;

tic
for i = 1:length(x)
    for j = 1:length(y)
        product = x(i)*y(j);
        z = num2str(product); %String maken
        if z(end:-1:1)== z; % getal gebruiken
            if product > answer
                answer = product;
            end
        end
    end
end
toc