%% Stabilitaet
clc;
clear;

f = @(x, y) -5.*y;
F = @(x) exp(-5.*x);

a = 0;
b = 5;

y0 = F(a);
n = 500;

[ x, y_euler, y_mittel, y_modeuler ] = eulerMittelMod( f, a, b, n, y0 );

h = (b-a) / n;
I = a:h:b;

plot(x, y_euler, x, F(x))