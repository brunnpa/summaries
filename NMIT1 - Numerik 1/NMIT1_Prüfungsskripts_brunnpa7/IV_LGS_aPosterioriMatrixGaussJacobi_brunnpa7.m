% A-POSTERIORI BERECHNUNG nach GAUSS oder JACOBI
%
% INPUT
% xn = x1
% xnl = x0
% b = bereits berechnetes b aus Gauss oder Jacobi
% tol = toleranz
% 
% OUTPUT
% r = boolean 1 wenn toleranz erreicht
%
% BEISPIELAUFRUF:
%
%
%
function [r] = IV_LGS_aPosterioriMatrixGaussJacobi_brunnpa7(xn, xn1, b, tol)
    fehlerabsch = (norm(b,inf)/(1-norm(b,inf)) * norm(xn-xn1,inf));
    r = fehlerabsch <= tol;
end