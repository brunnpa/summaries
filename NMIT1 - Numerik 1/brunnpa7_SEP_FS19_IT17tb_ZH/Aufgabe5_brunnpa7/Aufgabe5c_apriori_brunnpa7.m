% A-PRIORI BERECHNUNG NACH GAUSS ODER JACOBI
%
% INPUT
% b = bereits berechnetes B aus Gauss oder Jacobi
% tol = toleranz
% 
% OUTPUT
% n = geschätzte Anzahl Iterationen
%
%
function [n] = Aufgabe5c_apriori_brunnpa7(x0, x1, b, tol)
    n = log10(tol*(1-norm(b,inf))/(norm(x1-x0, inf)))/log10(norm(b, inf));
end


