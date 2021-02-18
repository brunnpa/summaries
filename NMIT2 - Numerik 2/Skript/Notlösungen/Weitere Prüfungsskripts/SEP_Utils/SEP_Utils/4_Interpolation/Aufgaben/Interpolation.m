%% Lagrange Skript: Bestimme Temperatur um 11:00
clear; clc;

x = [8.00, 10.00, 12.00, 15.00];
y = [11.2, 13.4, 15.3, 19.5];
p = lagrangeInterpolation(x, y);
disp(p(11));

%% S9 A1 Lagrande mit Integral

% a) Berechnung Lagrande

clear, clc;
x = [exp(1)-0.5, exp(1)-0.25, exp(1)+0.25, exp(1)+0.5];
y = [3.9203, 5.9169, 11.3611, 14.8550];
p = lagrange_interpolation(x,y);
disp(p(exp(1)));

% b) Analytische Lösung berechnen

int_analyt = 1 + exp(2);
err_abs = abs(p(exp(1)) - int_analyt);
err_rel = abs(err_abs./int_analyt);

% Aufgabe 1c
f = @(x) x.*log(x.^2);
a = 1;
b = exp(1);
m =4;
[D] = Romberg(a,b,f,m);
romberg_result = D(1,m);
err_abs_rom = abs(2.*romberg_result - int_analyt)
err_rel_rom = abs(err_abs_rom./int_analyt)

%% 