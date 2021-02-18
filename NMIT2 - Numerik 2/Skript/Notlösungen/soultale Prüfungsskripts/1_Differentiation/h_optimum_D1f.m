function [h_opt] = h_optimum_D1f(x0, f,fdiff2, my_eps)
%h_opt = h_optimum_D1f(1, @(x)sin(x), @(x)-sin(x));
% Berechnet optimale Schrittweite h für D1f(Vorwärtsdifferenz)
% x0: abzuleitende Punkte
% f: Funktion
% fdiff2: 2te Ableitung von f
% my_eps: Maschinengenauigkeit (e..g 2^-52)

if ~exist('my_eps','var')
    my_eps = eps;
end

h_opt = sqrt(4 .* my_eps .* abs(f(x0))./abs(fdiff2(x0)));

header = string(h_opt);
header(1,1) = "Optimale Schrittweiten";
h_opt_table = [header; string(x0); h_opt];
%disp(h_opt_table);
end

