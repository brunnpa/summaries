clc, clear;
h = [0.1, 0.05, 0.025, 0.0125];
f = @(x)log(x.^2);
x0 = 2;
%analytische Lösung für Fehlerberechnung
fdiff_analyt = @(x) 2./x;

%Ableitung D1f
D1f = @(x0, h,f) D1f(x0, h, f);
%h extrapolation
[D,E,D_table,E_table] = h_extrapolation(x0, h, f, D1f, fdiff_analyt);
disp("Results");
disp(D_table);
disp(E_table);

