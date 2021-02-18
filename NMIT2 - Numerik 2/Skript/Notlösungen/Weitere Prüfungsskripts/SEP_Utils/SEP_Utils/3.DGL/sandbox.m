%% Richtungsfeld

f = @(t, yt) t.^2 + 0.1 * yt;
xmin    = -1.5;
xmax    = 1.5;
ymin    = 0;
ymax    = 3;
hx      = 0.2;
hy      = 0.2;

richtungsfeld(f, xmin, xmax, ymin, ymax, hx, hy);

%% Klassisches Euler-Verfahren
clear; clc;
f = @(x, y) (x.^2)./y;
a = 0;
b = 2.1;
y0 = 2;
h = 0.7;
n = (b-a)/h;   %also 3
n = 3;


[~, y_klassisch]   = euler(f, a, b, n, y0);
[~, y_mitelpunkt]  = mittelpunkt(f, a, b, n, y0);
[x, y_modifiziert] =  modeuler(f, a, b, n, y0);
%% Klassisches 