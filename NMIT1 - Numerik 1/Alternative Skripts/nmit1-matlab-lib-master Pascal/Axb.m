% Löst das Gleichungsystem Ax = b den Gauss-Algorithmus und
% rechnet die Determinante für A
%
% A = [-1, 1, 1 ; 1, -3, -2 ; 5, 1, 4]
% b = [0 ; 5 ; 3]
% [x, determinant] = Axb(A, b)
%
% A           = Gleichungssystem als Matrix
% b           = Ziel-Vektor des Gleichungssystems
% x           = Lösung des Gleichungssystems
% determinant = Determinante der Matrix A
%
function [x, determinant] = Axb(A, b)
format rat

if (size(A,1) ~= size(b,1))
    error('Dimensions of Matrix and Vector do not match:\nMatrix: %d x %d, Vector: %d x %d', size(A,1), size(A,2), size(b,1), size(b,2)); 
end

determinant = det(A);

if(determinant == 0)
    error('Matrix A is singular'); 
end 
x = linsolve(A, b);

if(compare_matrices(A*x, b))
%disp('Ax == b')
else
%disp('Ax != b') 
end
end


% Dominique Reiser