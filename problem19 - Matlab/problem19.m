clear all;
clc;
%ja fe ma ap me ju ju au se ok no de
month_length =  [31 28 31 30 31 30 31 31 30 31 30 31];
type_day = 1;   %1 is maandag 2 is dinsdag etc.

counter = 0;
for year=1900:2000
    for month=1:12
        if (year >= 1901) && (mod(type_day, 7) == 0)
            counter = counter + 1;
        end;
        
        type_day = type_day + month_length(month); %tel het aantal dagen vanaf 1 jan 1900
        
        % schrikeljaar
        if (month == 2 && is_schrikkeljaar(year))
            type_day = type_day + 1;
        end;
    end;
end;

counter