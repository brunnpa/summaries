%Aufg5

%2.5
tol = 10^-3;

% Lösung mit Fixpunktiteration
syms x;
f = 2*sin(x);
df = diff(f);

clear x;

f = matlabFunction(f);
df = matlabFunction(df);

xn = pi/2;
n = 1;
while abs(f(xn) - xn) > tol
    xn = f(xn);
    n=n+1;
end

xn
n
abs(f(xn) - xn)
myF = @(x) 2*sin(x)-x;
myF(0)
myF(xn)
myF(-xn)
ezplot(myF);
grid on;
