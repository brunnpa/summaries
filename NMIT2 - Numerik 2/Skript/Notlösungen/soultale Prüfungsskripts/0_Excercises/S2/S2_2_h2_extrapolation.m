clc, clear;
x0 = 2;
h = [0.1, 0.05, 0.025, 0.0125];
f = @(x) log(x.^2);
fdiff_analyt = @(x) 2./x;
%nur D2f oder D4f (für 2.te ableitung) erlaubt
D2f = @(x0, h,f) D2f(x0, h, f);
[D,E,D_table,E_table] = h2_extrapolation(x0,h,f,D2f,fdiff_analyt);
disp(D_table);
disp(E_table);
