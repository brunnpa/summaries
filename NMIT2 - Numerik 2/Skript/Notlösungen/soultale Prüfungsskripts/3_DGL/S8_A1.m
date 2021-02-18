clc
clear

% Gegeben:
a = 0;
b = 1;
h = 0.1;
n = abs(b-a)/h;
z0 = [0;2;0;0]; % gleiche grösse wie Vektor in Funktion

% z Vektor bestimmen
f = @(x, z)[z(2); z(3); z(4); sin(x) + 5 - 1.1*z(4) + 0.1*z(3) + 0.3*z(1)];

% Verfahren wählen euler, rk4, ...
[t, y] = rk4(f, a, b, n, z0);

% Lösung: erste Spalte = z0, zweite Spalte = z1, ...