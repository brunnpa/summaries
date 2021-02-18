%Aufg3
syms x;
f = 1/5*x^3 + 3/5;
df = diff(f);
f = matlabFunction(f);
df = matlabFunction(df);
clear x;

% Konvergiert für einen Wert?
abs(df(0.5));
if abs(df(0.5)) < 1
    disp('Der Wert konvergiert');
end

% existiert alpha?
syms alpha;
equ = abs(f(0) - f(1)) == alpha * abs(0-1);
alphaExist = solve(equ, alpha);
if 0<=alphaExist && alphaExist<=1
   disp('Es existiert ein Alpha'); 
end

% berechnung
x0 = 0.5;
x1 = f(x0);
x2 = f(x1);
x3 = f(x2);
x4 = f(x3);
x5 = f(x4)