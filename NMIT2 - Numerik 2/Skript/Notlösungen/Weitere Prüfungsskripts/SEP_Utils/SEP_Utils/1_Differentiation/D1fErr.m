function [d1err] = D1fErr(h, x0, f)
% Berechnet den absoluten Fehler des D1f Verfahrens
% h:    Schrittweite
% x0:   Startwert
% f:    Funktion

% Vorraussetzungen
fDiff1  =  diff1(f);
d1f     =  D1f(h, x0, f);
%Kalkulation
d1err   =  abs( d1f - fDiff1(x0) );