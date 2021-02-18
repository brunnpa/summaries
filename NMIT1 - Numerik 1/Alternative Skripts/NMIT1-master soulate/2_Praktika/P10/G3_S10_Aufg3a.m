%Werte aus S10_Aufg 1
%[xn, n, n2] = G3_S10_Aufg3a([8 5 2; 5 9 1; 4 2 7], [19; 5; 34], [1; -1; 3], 10^-4, 'jacobi')
%[xn, n, n2] = G3_S10_Aufg3a([8 5 2; 5 9 1; 4 2 7], [19; 5; 34], [1; -1; 3], 10^-4, 'gaussSeidel')

function [xn, n, n2] = G3_S10_Aufg3a(A, b, x0, tol, opt)
%N ist log-base
logN = @(x, N) log(x)/log(N);

D = diag(diag(A));
L = tril(A) - D;
R = triu(A) - D;
Dinv = D^-1;
DLinv = (D+L)^-1;
DinvL = Dinv * L;

jacobi1 = -DinvL - Dinv *  R;
jacobi2 = Dinv * b;
jacobi = @(x) jacobi1 * x + jacobi2;

gaussSeidel1 = -DLinv * R;
gaussSeidel2 = DLinv * b;
gaussSeidel = @(x) gaussSeidel1 * x + gaussSeidel2;

if strcmp(opt, 'jacobi')
    func = jacobi;
    B = jacobi1;
    disp('Jacobi');
elseif strcmp(opt, 'gaussSeidel')
    func = gaussSeidel;
    B = gaussSeidel1;
    disp('Gauss-Seidel');
else
    error('Geben Sie entweder das "jacobi"- oder das "gaussSeidel"-Verfahren ein');
end

xOld = x0;
xNew = func(xOld);
% n2 nach apriori
n2 = logN(tol / (norm(xNew-x0, inf)) * (1 - norm(B, inf)), norm(B, inf)); 
n=1;

while abs(norm(xOld-xNew, inf)) > tol
    n = n+1;
    xOld = xNew;
    xNew = func(xOld);
    xn = xNew;
end