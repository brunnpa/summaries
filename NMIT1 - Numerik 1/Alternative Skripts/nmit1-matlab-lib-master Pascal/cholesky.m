% Führt für eine Matrix A die Cholesky Zerlegung aus
%
% A = [1, 2, 3 ; 2, 5, 7 ; 3, 7, 26]
% [R] = cholesky(A)
%
% A = Matrix für die die Cholesky Zerlegung gemacht werden soll
% R = Obere Dreiecksmatrix
%
function [R] = cholesky(A)

if(~compare_matrices(A, A'))
    error('Matrix A is not symetrical'); 
end

format rat

try [R] = chol(A);
catch ME
    error('Matrix A is not positive definite');
end

if(compare_matrices(A, R'*R))
disp('A == (R^T) * R')
else
disp('A != (R^T) * R') 
end
end


% Dominique Reiser
