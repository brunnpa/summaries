% Solve a system of linear equations, Ax = b, using LU decomposition
% Written by Zachary Ferguson

function x = lu_solve(L, U, b)
    % Solve the equation Ax = LUx = b acording to LU decomposition
    % Input:
    %   L - Lower triangular matrix of guassian multiplication values
    %   U - Row echelon form of A
    %   b - Right hand side of the linear equations
    % Output:
    %   x - solved value

    n = size(L, 1);
    
    % Perform Forward Substitution
    c = zeros(size(b));
    for i = 1 : n
        for j = 1 : i-1
            b(i) = b(i) - L(i, j) * c(j);
        end
        c(i) = b(i) / L(i, i);
    end


    % Perform Back Substitution
    x = zeros(size(b));
    for i = n : -1 : 1
        for j = i+1 : n
            c(i) = c(i) - U(i, j) * x(j);
        end
        x(i) = c(i) / U(i, i);
    end
end
