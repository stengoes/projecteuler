function [ neighborsFirst, neighborsLast ] = select_neighbors_sparse( ring, grid )
    %selects the neighbors of the first and last number of a ring
    
    neighborsFirst = zeros(1, 6);    %neighbor numbers
    neighborsLast = zeros(1, 6);    %neighbor numbers

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
    
    %calculate the offset
    ring = ring+2;
    
    %select all neighbors
    neighborsFirst(1) = grid(ring-1, ring-1);
    neighborsFirst(2) = grid(ring, ring-1);
    neighborsFirst(3) = grid(ring+1, ring);
    neighborsFirst(4) = grid(ring+1, ring+1);
    neighborsFirst(5) = grid(ring, ring+1);
    neighborsFirst(6) = grid(ring-1, ring);     
    
    if ring ~= 2
        neighborsLast(1) = grid(ring-2, ring-1);
        neighborsLast(2) = grid(ring-1, ring-1);
        neighborsLast(3) = grid(ring, ring);
        neighborsLast(4) = grid(ring, ring+1);
        neighborsLast(5) = grid(ring-1, ring+1);
        neighborsLast(6) = grid(ring-2, ring);  
    end;
end

