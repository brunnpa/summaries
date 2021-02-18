% Berechnet die a-posteori Abschätzung für Matrizen
%
% PARAM
% xn = x1
% xnl = x0
% B = berechnetes B aus Gauss oder Jacobi
% tol = toleranz
% 
% RETURN
% boolean ja wenn toleranz erreicht
function r = aPosterioriMatrix(xn, xn1, B, tol)
    fehlerabsch = (norm(B,inf)/(1-norm(B,inf)) * norm(xn-xn1,inf));
    r = fehlerabsch <= tol;
end