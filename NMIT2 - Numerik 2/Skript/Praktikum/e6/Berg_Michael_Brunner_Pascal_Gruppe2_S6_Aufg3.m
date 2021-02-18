% 3.a)
R = 4;
r = 0.04;
a = 0;
b = 10;
h = 0.1;
n = (b-a)/h;
y(1) = 2;
dydx = @(x,y) (x.^2)/y;

f = @(x) sqrt((2*x.^3)/3 +4);

[~, yKutta] = Berg_Michael_Brunner_Pascal_Gruppe2_S6_Aufg1(dydx, a, b, n, y(1));
[~,y_euler] = euler(dydx, a, b, n, y(1));
[~,y_mittelpunkt] = mittelpunktverfahren(dydx, a, b, n, y(1));
[x,y_modeuler] = modeuler(dydx, a, b, n, y(1));

for i=1:n+1
    abs_Fehler_euler(i) = abs(f(x(i)) - y_euler(i));
    abs_Fehler_mittelpunkt(i) = abs(f(x(i)) - y_mittelpunkt(i));
    abs_Fehler_modeuler(i) = abs(f(x(i)) - y_modeuler(i));
    abs_Fehler_runga_kutta(i) = abs(f(x(i)) - yKutta(i));
end

plot(x,yKutta);
grid minor;
hold on;
plot(x,y_euler);
plot(x,y_mittelpunkt);
plot(x,y_modeuler);
legend('RK4', 'Euler', 'Mittelpunkt', 'ModEuler');
title('Lösungsvergleich');
xlim([0 10]);

figure();
semilogy(x,abs_Fehler_runga_kutta);
hold on;
grid minor;
semilogy(x,abs_Fehler_euler);
semilogy(x,abs_Fehler_mittelpunkt);
semilogy(x,abs_Fehler_modeuler);
title('lokaler Fehler');

legend('RK4', 'Euler', 'Mittelpunkt', 'ModEuler');