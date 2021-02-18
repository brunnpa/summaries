function [xn,n] = linSolveJacobi(A,b,x0,tol,nmax)

m = size(A,1);
xn = 2*tol*ones(size(x0));
n = 1;

while norm(xn-x0,inf) >= tol && n < nmax
    x0 = xn;
    for i=1:m
        xn(i) = 1/A(i,i)*(b(i) - A(i,1:i-1)*x0(1:i-1) - A(i,i+1:m)*x0(i+1:m));
    end
    n = n+1;
end

% Diagonaldimonanz: 10 + 30 < 15
%                   10 +20 < 40
%                   10 + 20 < a

% A = [30 10 15; 10 40 20; 15 20 a];
% b = [a;-a;2*a];
% nmax = 300;
% x0 = [0;0;0];
