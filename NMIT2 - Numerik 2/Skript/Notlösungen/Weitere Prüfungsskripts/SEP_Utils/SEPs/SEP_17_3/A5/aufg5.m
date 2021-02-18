clear;
clc;
hold off;
close all;

% gegebene Punkte   --> ges. Funktion: z.B. f(x) = a*x^2 + b*x + c
x = [0 10 20 30 40 50 60 70 80 90 100 110];
y = [76 92 106 123 137 151 179 203 227 250 281 309]';
% Normalgleichungssystem aufstellen für f
f4 = @(x) x.^3;
f3 = @(x) x.^2;
f2 = @(x) x.^1;
f1 = @(x) x.^0;
n = length(x);
A1 = [f4(x)' f3(x)' f2(x)' f1(x)'];
At_A1 = A1'*A1;
% lambda berechnen  --> lambda(1) = a, lambda(2) = b, lambda(3) = c
lambda1 = At_A1\(A1'*y);
a1 = lambda1(1);
a2 = lambda1(2);
a3 = lambda1(3);
a4 = lambda1(4);

% Normalgleichungssystem aufstellen für g
g3 = @(x) x.^2;
g2 = @(x) x.^1;
g1 = @(x) x.^0;
A2 = [g3(x)' g2(x)' g1(x)'];
At_A2 = A2'*A2;
% lambda berechnen  --> lambda(1) = a, lambda(2) = b, lambda(3) = c
lambda2 = At_A2\(A2'*y);
b1 = lambda2(1);
b2 = lambda2(2);
b3 = lambda2(3);

% plot
x_plot = 0:0.01:115;
p1 = a1.*x_plot.^3 + a2.*x_plot.^2 + a3.*x_plot + a4;
p2 = b1.*x_plot.^2 + b2.*x_plot + b3;
plot(x,y, 'x');
hold on;
plot(x_plot, p1);
plot(x_plot, p2);
grid on;
legend('data points', 'p1(t)', 'p2(t)');

p1 = @(x) a1.*x.^3 + a2.*x.^2 + a3.*x + a4;
p2 = @(x) b1.*x.^2 + b2.*x + b3;

% Fehlerfunktionale
E_p1 = sum((y' - p1(x)).^2);
E_p2 = sum((y' - p2(x)).^2);
% b) p1 hat das Fehlerfunktional 66.4835, p2 hat das Fehlerfunktional
% 66.9311. Beide n�hern die Punkte ziemlich gut an, p1 aber ein bisschen
% besser.