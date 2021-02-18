clc;
format long;

% ====================================================================== %
% Script: Romberg Extrapolation mit
%         - summierter Rechteckregel (DF1)
%         - summierter Trapezregel (TF1)
%
% Beschreibung:
% Berechnung mittels Romberg Extrapolation. Entweder ausfuerhbar unter
% Verwendung der summierten Rechteckregel oder der summierten Trapezregel
% durch ein/-auskommentieren der entsprechenden Zeile /siehe TODO)
% ====================================================================== %


f = @(x)cos(x.^2);
a = 0;
b = pi;
m = 4;


[T,E] = func_romberg_extrapolation(f,a,b,m);

h_opt = T(1,m+1);

format short;

fprintf('T:\n');
disp(T);

fprintf('E:\n');
disp(E);

format long;

fprintf('\nOptimales h: %f\n', h_opt);