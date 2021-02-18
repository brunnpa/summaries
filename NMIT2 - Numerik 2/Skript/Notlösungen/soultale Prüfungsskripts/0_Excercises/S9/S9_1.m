%Aufgabe 1a
clear, clc;
x = [exp(1)-0.5, exp(1)-0.25, exp(1)+0.25, exp(1)+0.5];
y = [3.9203, 5.9169, 11.3611, 14.8550];
p = lagrange_interpolation(x,y);
disp(p(exp(1)));

%Aufgabe 1b
%analyt Lösung: integral über partielle Integration
%bestimmtes Integral von 1 - e = 1 + exp(2)
int_analyt = 1 + exp(2);
err_abs = abs(p(exp(1)) - int_analyt);
err_rel = abs(err_abs./int_analyt);

%Aufgabe 1c
f = @(x) x.*log(x.^2);
a = 1;
b = exp(1);
m =4
[D, D_table] = romberg_extrapolation(a,b,f,m);
romberg_result = D(1,m);
err_abs_rom = abs(2.*romberg_result - int_analyt)
err_rel_rom = abs(err_abs_rom./int_analyt)

%Aufgabe 2/3
[ y, p ] = Aitken_Neville( [0, 2500, 5000, 10000], [1013, 747, 540, 226], 1250 );
disp(p);
disp(y);
[ y, p ] = Aitken_Neville( [0, 2500, 5000, 10000], [1013, 747, 540, 226], 3750 );
disp(p);
disp(y);