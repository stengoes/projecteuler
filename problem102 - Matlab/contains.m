function [ result ] = contains( A, B, C, T )
    result = 0;
    
    AB = [B(1)- A(1); B(2)-A(2); 0];
    AC = [C(1)- A(1); C(2)-A(2); 0];      
    AT = [T(1)- A(1); T(2)-A(2); 0];
    BT = [T(1)- B(1); T(2)-B(2); 0];
    BC = [C(1)- B(1); C(2)-B(2); 0];
    
    totalArea   = abs(cross(AB, AC)) * 0.5;
    subArea1    = abs(cross(AT, AC)) * 0.5;
    subArea2    = abs(cross(AT, AB)) * 0.5;
    subArea3    = abs(cross(BT, BC)) * 0.5;   
    
    if totalArea == (subArea1 + subArea2 + subArea3)
        result = 1;
    end
end

