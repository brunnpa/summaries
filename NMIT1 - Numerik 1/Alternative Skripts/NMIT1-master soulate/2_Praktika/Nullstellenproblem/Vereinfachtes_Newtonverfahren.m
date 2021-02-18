clear;
clc;
hold off;
close all;

% Funktion
func = @(x) x.^2-2;
% Funktion abgeleitet
func_diff = @(x) 2*x;
% Startwert
x(1) = 2;
% Toleranz
tol = 10^-4;
i = 2;
x(2) = x(i-1) - func(x(i-1))/func_diff(x(1));
while abs((x(i)-x(i-1))) >= tol
    i = i+1;
    x(i) = x(i-1) - func(x(i-1))/func_diff(x(1));
end

% angenäherte Lösung
sol = x(i);