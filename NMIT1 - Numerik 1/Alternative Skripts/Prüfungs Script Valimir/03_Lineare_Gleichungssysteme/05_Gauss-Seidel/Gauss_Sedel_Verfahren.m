%GAUSS-SEDEL VERFAHREN
A = [4 -1 1; -2 5 1; 1 -2 5];
b = [5;11;12];
x0 = [0;0;0];
max_n = 5;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('-(D+L)^(-1)Rxn + (D+L)^(-1)b');
diagA = diag(A);
D = diag(diagA)
L = tril(A)-D
R = triu(A)-D
b

disp('(D+L)x^(k+1) = -Rx^(k) + b');
DL = D+L
R
b

disp('________________________________________________________');
disp(' ');

n = 0;
x1 = x0;
for(i=0:1:max_n)
    fprintf('i = %d;   xi =\n', n);
    disp(x1);
    x1 = -inv(D+L)*R*x1+inv(D+L)*b;
    n = n+1;
end