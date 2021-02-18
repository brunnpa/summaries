clear, clc;
% integral von 0 bis pi von cos(x^2) 
% mittels romberg extrapolation
a = 0;
b = pi;
f = @(x) cos(x.^2);
%i elem (0,...,4)
m = 5;

[T, T_table] = romberg_extrapolation(a,b,f,m);

disp(T_table);