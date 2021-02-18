% Funktion und Startwerte eingeben
f = @(x, y) [y(2), -(0.16./1) .* y(2) - 9.81./1.2 .* sin(y(1))];
a = 0;
b = 60;
h = 0.1;
y0 = [pi/2;0];
n = (b-a)/h;

[x,y] = runge_kutta_4_stfg(f, a, b, n, y0);
plot(x,y(:,1));