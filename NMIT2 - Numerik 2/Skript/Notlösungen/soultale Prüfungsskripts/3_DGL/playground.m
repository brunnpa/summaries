clear;
clc, clf;
y_analyt = @(x) -10.*x.^2 - 200.*x - 2000 + 1722.5.*exp(0.05.*(2.*x+3));

f_diff = @(x, y) x.^2 + 0.1.*y;
a = -1.5; %=x0
b = 1.5;
n = 10;
y0 = 0;

[x_euler, y_euler ] = euler(f_diff,a,b,n,y0);
plot(x_euler, y_euler, 'b');
hold on;
analyt_sol=y_analyt(x_euler);
plot(x_euler, analyt_sol, 'r');
[x_mittelpunkt, y_mittelpunkt] = mittelpunkt(f_diff,a,b,n,y0);
plot(x_mittelpunkt, y_mittelpunkt, 'g');
[x_modeuler, y_modeuler] = modeuler(f_diff,a,b,n,y0);
plot(x_modeuler, y_modeuler, 'g');
[x_rk4, y_rk4] = rk4(f_diff,a,b,n,y0);
plot(x_rk4, y_rk4, 'b');
legend('Euler', 'Analytic', 'Mittelpunkt', 'Mod.Euler', 'Rk4');
[x_ab4, y_ab4] = adams_bashforth_s(f_diff,a,b,n,y0,4);
plot(x_ab4, y_ab4, 'r--');

legend('Euler',  'Mittelpunkt', 'Mod.Euler', 'Rk4');
%richtungsfeld(f, a, b, 0, 3, 0.3, 0.3 )

clf;
y_analyt = y_analyt(x_euler);
plot(x_modeuler, abs(y_euler-y_analyt), 'b');
hold on;
plot(x_modeuler, abs(y_mittelpunkt-y_analyt), 'g');
plot(x_modeuler, abs(y_modeuler-y_analyt), 'b');
plot(x_modeuler, abs(y_rk4-y_analyt), 'r');
plot(x_modeuler, abs(y_ab4-y_analyt), 'gx');
%

%vgl = [[1:n+1]', x_euler',analyt_sol', y_euler', y_mittelpunkt', y_modeuler' ];
%disp(vgl);
