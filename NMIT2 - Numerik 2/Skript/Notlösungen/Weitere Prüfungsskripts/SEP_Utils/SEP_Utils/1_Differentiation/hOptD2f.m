function [hopt] =   hOptD2f(eps, x0, f)
% Berechnet die optimale Schrittweite für eine gegebene
% Maschinengenauigkeit
%
% eps:  Maschinengenauigkeit
% xo:   Stelle, an der die Ableitung berechnet wird
% f:    Funktion, für welche die optimale Schrittweite berechnet wird

fDiff1 = diff1(f);
fDiff2 = diff2(f);
fDiff3 = diff3(f);

hopt = nthroot( 6 * eps * (abs(fDiff1(x0)) / abs(fDiff3(x0))), 3);