clear all;
clc;

cc = '';
i = 1;
while size(cc, 2) <= 1000000
    cc = strcat(cc,num2str(i));
    i = i + 1;
end

% dn = nth
d1 = cc(1); 
d10 = cc(10);
d100 = cc(100);
d1000 = cc(1000);
d10000 = cc(10000);
d100000 = cc(100000);
d1000000 = cc(1000000);

answer = d1 * d10 * d100 * d1000 * d10000 * d100000 * d1000000