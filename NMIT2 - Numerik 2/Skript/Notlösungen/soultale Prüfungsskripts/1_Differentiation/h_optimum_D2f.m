function [h_opt] = h_optimum_D2f(x0, f,fdf3, my_eps)
% h_opt_d2f = h_optimum_D2f(1, @(x)sin(x), @(x)-sin(x));
% expected: 1.100349098440101e-05
% Berechnet optimale Schrittweite h für D1f(Vorwärtsdifferenz)
% x0: abzuleitende Punkte
% f: Funktion
% fdiff3: 3te Ableitung von f
% my_eps: Maschinengenauigkeit (e..g 2^-52)

if ~exist('my_eps','var')
    my_eps = eps;
end

h_opt = (6 .* my_eps .* abs(f(x0))./abs(fdf3(x0))).^(1/3);

header = string(h_opt);
header(1,1) = "Optimale Schrittweiten";
h_opt_table = [header; string(x0); h_opt];
%disp(h_opt_table);
end

