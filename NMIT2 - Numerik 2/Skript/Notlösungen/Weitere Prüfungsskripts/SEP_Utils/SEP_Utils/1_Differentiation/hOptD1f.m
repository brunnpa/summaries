function [hopt] =   hOptD1f(eps, x0, f)
% Berechnet die optimale Schrittweite für eine gegebene
% Maschinengenauigkeit
%
% eps:  Maschinengenauigkeit
% xo:   Stelle, an der die Ableitung berechnet wird
% f:    Funktion, für welche die optimale Schrittweite berechnet wird

fDiff1 = diff1(f);
fDiff2 = diff2(f);

hopt = sqrt ( 4 * eps * abs(fDiff1(x0)) / abs(fDiff2(x0)) );