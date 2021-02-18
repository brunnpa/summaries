%JACCOBI VERFAHREN
A = [4 -1 1; -2 5 1; 1 -2 5];
b = [5; 11; 12];
x0 = [0;0;0];
max_n = 5;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('-D^(-1)((L+R)xn + D^(-1)b)');
diagA = diag(A);
D = diag(diagA)
L = tril(A)-D
R = triu(A)-D
b

disp('-D^(-1)((L+R)xn + D^(-1)b) = -(invD)((LR)xn + (invDb))');
invD= inv(D)
LR = L+R
invDb = invD*b

disp('-(invD)((LR)xn + invDb) = (-invDLR)xn + (invDb)');
invDLR = -invD*LR
invDb
disp('________________________________________________________');
disp(' ');

n = 0;
x1 = x0;
for(i=0:1:max_n)
    fprintf('i = %d;   xi =\n', n);
    disp(x1);
    x1 = -inv(D)*(L+R)*x1+inv(D)*b;
    n = n+1;
end