clear;
clc;
hold off;
close all;

% Toleranz
tol = 10^-6;
% Anfangspunkt
x = 0.7;
i = 2;
% Funktion      Form: x = F(x)
func = @(x) nthroot(x-0.3,3);
x(i) = func(x(i-1));
while(abs((x(i)-x(i-1))) >= tol)
    i = i+1;
    x(i) = func(x(i-1));
end
% genäherte Lösung
sol = x(i);