A = diag(diag(ones(3000) * 4000)) + ones(3000);
x = [1:1:1500, 1500:-1:1]';
b = A * x;
x0 = zeros(3000, 1);
tol = 1e-4;

timeJacobi = tic;
G3_S10_Aufg3a(A, b, x0, tol, 'jacobi');
toc(timeJacobi);

timeGaussSeidel = tic;
G3_S10_Aufg3a(A, b, x0, tol, 'gaussSeidel');
toc(timeGaussSeidel);

disp('Gauss');
timeGauss = tic;
G3_S7_Aufg2(A,b);
toc(timeGauss);

%Der Gauss Alg. braucht gute 55 mal länger.
%Jacobi: 5.002567 Sekunden
%Gauss-Seidel: 4.713944 Sekunden
%Gauss: 282.014450 Sekunden