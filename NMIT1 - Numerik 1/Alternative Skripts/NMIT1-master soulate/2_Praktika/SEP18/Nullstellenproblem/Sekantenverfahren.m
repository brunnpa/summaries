clear;
clc;
hold off;
close all;

% Funktion
func = @(x) x.^2-2;
% untere Schranke
x(1) = 1;
% obere Schranke
x(2) = 2;
% Toleranz
tol = 10^-4;
i = 2;
while abs((x(i)-x(i-1))) >= tol
    i = i+1;
    x(i) = x(i-1) - ((x(i-1)-x(i-2))/(func(x(i-1))-func(x(i-2))))*func(x(i-1));
end

% angenäherte Lösung
sol = x(i);