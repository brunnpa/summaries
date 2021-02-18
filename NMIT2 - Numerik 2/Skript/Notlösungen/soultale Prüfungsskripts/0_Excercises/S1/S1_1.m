clear, clc; 
format long;

%Taylor-Polynom von Grad 7 um Stelle x0=0
n = 0:7;
% um Stelle x0=0
x0 = 0;
% für Funktion f
f = @(x) exp(1).^x;
%f = fdiff = fdiff2 = ... =fdiff7
%=> alle Ableitungen d gleich f(x0)
d = zeros([1,8]);
d(:) = f(x0);

syms x;
taylor_series = (d ./factorial(n)).*(x - x0).^n;

tp7 = matlabFunction(sum(taylor_series));

%Näherung mit tp7 bei 1
approx_1 =  tp7(1);
error_1 = abs(approx_1 - f(1));
fprintf('Fehler tp7 bei x=1: %1.4d\n', error_1);

%exp(1) = (sum 1 to Inf)1./k;
