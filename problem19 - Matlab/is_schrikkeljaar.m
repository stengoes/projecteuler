function [ bool ] = is_schrikkeljaar( jaar )

    if( mod(jaar, 4) == 0 )
        if(mod(jaar, 100) == 0)
            if(mod(jaar, 400) == 0)
                bool = 1;
                return;
            else
                bool = 0;
                return;
            end;
        else
            bool = 1;
            return;
        end;
    end;
    
    bool = 0;
    return;
end

