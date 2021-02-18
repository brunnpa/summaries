%Aufg5 2.7

syms x;
f = x^2-2;
df = diff(f);

clear x;
f = matlabFunction(f);
df = matlabFunction(df);

%newton
newton = @(xn) xn - f(xn)/df(xn);
xn = 1.4;
xn = newton(xn);
xn = newton(xn);
disp(['Newtonverfahren:', num2str(xn)]);

%vereinfachtes newton
x0=1.4;
df0=df(x0);
newtonEinf = @(xn) xn - f(xn)/df0;
xn = x0;
xn = newtonEinf(xn);
xn = newtonEinf(xn);
disp(['Vereinfachtes-Newtonverfahren:', num2str(xn)]);

%sekantenverfahren
sek = @(x0, x1) x1 - ((x1-x0) / (f(x1)-f(x0))) * f(x1);
x0=1.2;
xn = 1.4;
x0 = sek(x0, xn);
xn = sek(xn, x0);
disp(['Sekantenverfahren:', num2str(xn)]);