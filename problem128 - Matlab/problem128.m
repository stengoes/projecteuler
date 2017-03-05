clear all;
clc;
close all;

%test the grid function
num_rings = 70000;
grid = create_grid_spdiag(num_rings);

count = 0;
target = 2000;

tic
    ring = 0;
    while count < target  

        first = grid(ring+2, ring+2);
        last  = grid(ring+1, ring+2);

        [neighborsFirst, neighborsLast] = select_neighbors_sparse(ring, grid);
   
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
        
        PDfirst = 0;    
        for i = 1:size(neighborsFirst, 2)
            difference = abs(neighborsFirst(i) - first);

            if isprime(difference)
                PDfirst = PDfirst + 1; 
            end;
        end;

        if PDfirst == 3
            count = count + 1;
            fprintf('tile %i = %i \n', count, full(first));
        end;

        if(ring ~= 0)
            PDlast = 0;    
            for i = 1:size(neighborsLast, 2)
                difference = abs(neighborsLast(i) - last);

                if isprime(difference)
                    PDlast = PDlast + 1; 
                end;
            end;

            if PDlast == 3
                count = count + 1;
                fprintf('tile %i = %i \n', count, full(last));
            end;
        end;

        ring = ring + 1;
    end;
stop = toc

