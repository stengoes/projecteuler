clear all;
clc;

%test point
T = [0, 0];

%load the triangles
data = load('p102_triangles.txt');
Ntriangles = size(data, 1);

answer = 0;

%for each triangle
for i = 1:Ntriangles    
    
    % readout the points
    triangle = data(i, :);
    A = [triangle(1), triangle(2)];
    B = [triangle(3), triangle(4)];
    C = [triangle(5), triangle(6)];
    
    %check if traingle ABC contains the test point T
    if(contains(A,B,C,T))
        answer = answer + 1;
    end;
end;