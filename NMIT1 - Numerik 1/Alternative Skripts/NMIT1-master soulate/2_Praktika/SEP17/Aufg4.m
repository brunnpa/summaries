% Aufg4
syms x;
f = 6 * (exp(x)-exp(-x))/(exp(x)+exp(-x)) + x;
df = diff(f);

clear x;

f = matlabFunction(f);
df = matlabFunction(df);

newton = @(xn) xn - f(xn) / df(xn);

x0 = 4;

x1 = newton(x0)
f(x1)
x2 = newton(x1)
f(x2)
x3 = newton(x2)
f(x3)

ezplot(f);
grid on;
xlim([-13 13]);