clear;
clc;
hold off;
close all;

% f,a,b,n,y0

% Diff.gleichung
f = @(x,y) [y(2) y(3) 10.*exp(-x)-5.*y(3)-8.*y(2)-6.*y(1)]';
% Intervall a - b
a = 0;
b = 1;
% Anzahl Schritte
n = 2;
% Schrittweite
h = (b-a)/n;
% Anfangswert an Stelle a
y0 = [2 0 0]';

x = zeros(1,n+1);
x(1) = a;
% x-Werte abfüllen
for i = 1 : n
    x(i+1) = x(i) + h;
end

% Euler-Verfahren

y_euler = zeros(length(y0),n+1);
y_euler(:,1) = y0;

for j = 1 : n
    y_euler(:,j+1) = y_euler(:,j) + h .* f(x(j),y_euler(:,j));
end
