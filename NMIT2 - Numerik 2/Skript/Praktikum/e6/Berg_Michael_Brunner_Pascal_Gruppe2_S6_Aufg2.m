% 2.a)
R = 4;
r = 0.02;
a = 0;
b = 24000;
n = 6;
y(1) = 6.5;
f = @(x,y) -(r.^2 * (2*9.81*y(1))^0.5)/(2*y(1)*R-y(1).^2);

[x, y] = Berg_Michael_Brunner_Pascal_Gruppe2_S6_Aufg1(f, a, b, n, y(1));

plot(x,y);
grid minor;
hold on;

%2.b)

[~,y_euler] = euler(f, a, b, n, y(1));
[~,y_mittelpunkt] = mittelpunktverfahren(f, a, b, n, y(1));
[x,y_modeuler] = modeuler(f, a, b, n, y(1));

xlim([0 24000]);
plot(x,y_euler);
plot(x,y_mittelpunkt);
plot(x,y_modeuler);
legend('RK4', 'Euler', 'Mittelpunkt', 'ModEuler');