% löst iterativ ein Gleichungssystem Ax = b entweder nach Jacobi oder nach
% Gauss-Seidel
%
% A = [4, -1, 1 ; -2, 5, 1 ; 1, -2, 5]
% b = [5 ; 11 ; 12]
%
% [xn] = jacobi_gauss_seidel_iteration(A, b, zeros(3, 1),3, 'Jacobi')
% [xn] = jacobi_gauss_seidel_iteration(A, b, zeros(3, 1),3, '')
%
% A   = Gleichungssystem als Matrix
% b   = Lösung des Gleichungssystems
% x0  = startVektor
% opt = 'Jacobi' wenn jacobi sonst '' für gauss-seidel
% xn  = Iterationsvektor nach n Iterationen
% n   = Anzahl max Iterationen
%
function [xn] = jacobi_gauss_seidel_iteration(A,b,x0,n,opt)
[dominant, dominantByRow, dominantByCol] = is_diagonaly_dominant(A);
if(~dominant)
    warning('Es kann sein, dass das Gleichungssystem nicht konvergiert, da A nicht diagonaldominant ist')
end

format long
D = diag(diag(A));
L = tril(A)-D;
R = triu(A)-D;

clear A;

xn = x0;

for i= 1:n
    if (strcmp(opt, 'Jacobi'))
        B = -1*D\(L+R);
        xn = jacobi(L, D, R, b, xn);
    else
        B = -1*(D+L)\R;
        xn = gaussSeidel(L, D, R, b, xn);
    end
end
clear L D  R  b;
end

function xn = jacobi(L, D, R , b, xn)
xn = (-1)*D\(L+R)*xn+D\b;
end

function xn = gaussSeidel(L, D, R, b, xn)
xn = (-1*(D+L)\R*xn) + ((D+L)\b);
end



% Dominique Reiser