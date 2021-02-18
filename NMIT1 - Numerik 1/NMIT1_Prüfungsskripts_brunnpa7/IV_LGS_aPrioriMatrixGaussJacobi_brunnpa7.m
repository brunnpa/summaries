% A-PRIORI BERECHNUNG NACH GAUSS ODER JACOBI
%
% INPUT
% b = bereits berechnetes B aus Gauss oder Jacobi
% tol = toleranz
% 
% OUTPUT
% n = geschätzte Anzahl Iterationen
%
% BEISPIELAUFRUF
%
%
function [n] = IV_LGS_aPrioriMatrixGaussJacobi_brunnpa7(x0, x1, b, tol)
    x0 = [4;2;7];
    x1 = [4.2; 2.65; 7.5];
    b = [0 -0.4 -0.2; -0.25 0 -0.4; -0.5 -0.16667 0];
    tol = 10^-4;
    n = log10(tol*(1-norm(b,inf))/(norm(x1-x0, inf)))/log10(norm(b, inf));
end


