%Aufg5 2.6

syms alpha;
f = pi/(2*cos(alpha)) + alpha - pi - tan(alpha);
df = diff(f);

clear alpha;
f = matlabFunction(f);
df = matlabFunction(df);

ezplot(f);
grid on;

newton = @(xn) xn - f(xn) / df(xn);

xn = 1;
while abs(f(xn)) > 0.0001
    xn = newton(xn)
end