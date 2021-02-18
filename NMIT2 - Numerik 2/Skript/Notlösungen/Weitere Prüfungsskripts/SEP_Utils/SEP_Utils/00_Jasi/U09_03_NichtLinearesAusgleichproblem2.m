% x und y Werte einsetzen %-- EDIT
x = 0:1:4; 
y = [3 1 0.5 0.2 0.05];

% Fehlerfunktional erstellen und partiell ableiten mach a, b, etc.
syms a b  %-- EDIT
f = @(x) a*exp(b*x);
E = 0;
for i = 1:length(x)
   E = E +  (y(i) -  f(x(i)))^2; 
end

f1 = diff(E,a); %-- EDIT
f2 = diff(E,b); %-- EDIT
%f3 ....

% JacobiMatrix erstellen und nach xn ableiten, wobei a und b Konstanten
% sind %-- EDIT
Df = jacobian ([f1, f2], [a b]);
Df = matlabFunction(Df);
f1 = matlabFunction(f1);
f2 = matlabFunction(f2);


% Newton-Verfahren anwenden %-- EDIT
fvec = @(x) [f1(x(1), x(2)); f2(x(1), x(2))];
Dfvec = @(x) Df(x(1), x(2));
tol = 1e-5;
x0 = [3, -1]';
xn = x0;
err = tol + 1;
n = 0;
while err>tol
Dx = -Dfvec(xn)\fvec(xn); 
xn = xn+Dx;
err = norm(fvec(xn), 2);
n = n+1;
end
format long

% Lösung
disp(xn)