clear;
clc;
hold off;
close all;

% (f,a,b,n,y0)
% Diff.gleichung
f = @(x,y) [y(2) y(3) y(4) sin(x) + 5 - 1.1.*y(4) + 0.1.*y(3) + 0.3.*y(1)];
% Intervall a - b
a = 0;
b = 1;
% Anzahl Schritte
n = 10;
% Schrittweite
h = (b-a)/n;
% Startwert
y0 = [0 2 0 0]';

x = zeros(1,n+1);
x(1) = a;
y = zeros(length(y0),n+1);
y(:,1) = y0;
k1 = zeros(length(y0),n+1);
k2 = zeros(length(y0),n+1);
k3 = zeros(length(y0),n+1);
k4 = zeros(length(y0),n+1);
for i = 1 : n
    k1(:,i) = f(x(i), y(:,i));
    k2(:,i) = f(x(i)+h/2, y(:,i)+h/2*k1(:,i));
    k3(:,i) = f(x(i)+h/2, y(:,i)+h/2*k2(:,i));
    k4(:,i) = f(x(i)+h, y(:,i)+h*k3(:,i));
    x(i+1) = x(i) + h;
    y(:,i+1) = y(:,i) + h/6*(k1(:,i)+2*k2(:,i)+2*k3(:,i)+k4(:,i));
end

% plot von RK4-Lösung, exakter Lösung und Richtungsfeld
% y_exakt = exp(x);
% plot(x, y);
% hold on;
% plot(x, y_exakt);
% grid on;
% dgl_plot_richtungsfeld(f, 0, 1, 0, 3, 0.1, 0.1);
% hold on;