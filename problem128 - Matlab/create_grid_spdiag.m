function [ grid ] = create_grid_diag( num_rings )    
    % Store the hexagonal grid data structure in the following way:
    %
    %        20 37 36 35 
    %        21 08 19 18 34
    %        22 09 02 07 17 33
    %        23 10 03 01 06 16 32
    %           24 11 04 05 15 31
    %              25 12 13 14 30
    %                 26 27 28 29
    %
    
    % -1 00 01 02 03 04 05
    % 05 01 02 08 20 38 62
    
    A = zeros(num_rings+3, 4);
    
    A(1, :) = [4 5 15 31]; 
    A(2, :) = [3 1 6 16]; 
    A(3, 4) = 17;
    
    A(3:end, 1) = cumsum(6:6:6*(num_rings+1)) + 3;
    A(3:end, 2) = cumsum(0:6:6*num_rings) + 2;
    A(3:end, 3) = cumsum(6:6:6*(num_rings+1))+1;
    A(4:end, 4) = cumsum(12:6:6*(num_rings+1))+6;
    
    grid = spdiags(A, [-1 0 1 2], num_rings+3, num_rings+3);    
    
    %test_grid = full(spdiags(grid, [-1 0 1 2], num_rings, num_rings));

end

