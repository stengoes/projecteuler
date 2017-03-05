clear all;
clc;


    %1_2_3_4_5_6_7_8_9_0
%int64 x =  1999999999999999990; %:-1:1020000000000000000;

x = int64(1020000000000000000)
while( x <= 1999999999999999990)
    temp = sqrt(x);
    if temp == int64(temp)
        break;
    end;
    x = x + 1;
end;