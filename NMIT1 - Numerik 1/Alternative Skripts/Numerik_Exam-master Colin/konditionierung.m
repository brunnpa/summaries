% Berechnet den relativen und absoluten Fehler einer gestörten Matrix und
% Vektor
%
% PARAMETER
% A = richtige Matrix, Af = Fehlerbehaftete Matrix
% b = richtiger Vektor, bf = Fehlerbehafteter Vektor
%
% RETURN
% x = Resultat mit den korrekten Input Werten
% xf = Resultat mit den falschen Input Werten
% dxmax = Absoluter Fehler
% dxobs = Relativer Fehler
%
% SAMPLE
% [x,xf,dxmax,dxobs] = konditionierung([20000, 30000, 10000; 10000, 17000, 6000; 2000, 3000, 2000], [19900, 29900, 9900; 9900, 16900, 5900; 1900, 2900, 1900], [5720000;3300000;836000], [5820000;3400000;936000])
function [x,xf,dxmax,dxobs] = konditionierung(A,Af,b,bf)
% Calculate the result vectors
x = linsolve(A, b);
xf = linsolve(Af, bf);

% Calculate some pre-results
normB = norm(b, inf);
condA = cond(A, inf);
normAf_normA = norm(A-Af, inf)/norm(A, inf);
normbf_normb = norm(b-bf, inf)/norm(b, inf);
% Calculate relative fail
% It is important that the norm value of b is greater than 0 because it is
% needed as a divisor
% In addition, the second condition must also be met
if ( (normB > 0) && (condA*normAf_normA) < 1)
    
    firstPart = condA / (1- condA * normAf_normA);
    
    secondPart = normAf_normA + normbf_normb;
    dxmax = firstPart * secondPart;
else
    dxmax = NaN;
end
% Calculate absolte value
dxobs = norm(x-xf, inf) / norm(x, inf);
end

