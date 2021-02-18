% Decompose the matrix A in to an L and U matrix such that A = LU
% Written by Zachary Ferguson

function [L, U] = lu_decomposition(A, eps)
    % Decompose the matrix A in to an L and U matrix such that A = LU
    % Input:
    %   A - matrix to decompose
    %   eps - tolerance of a zero pivot
    % Output:
    %   [L, U] - deomposed version of A
    if nargin < 2
            eps = 1e-9;
    end

    n = size(A, 1);
    
    % L is the multipliers of A to get U
    L = eye(n);

    % Elimination step (O(2/3 * n^3))
    for j = 1 : n-1
        if abs(A(j, j)) < eps
            error('Zero Pivot encountered.');
        end
        for i = j+1 : n
            mult = A(i, j) / A(j, j);
            for k = j : n
                A(i, k) = A(i, k) - mult * A(j, k); % Row operation
            end
            L(i, j) = mult;
        end
    end

    % U is the row echelon form of A
    U = A;
end
