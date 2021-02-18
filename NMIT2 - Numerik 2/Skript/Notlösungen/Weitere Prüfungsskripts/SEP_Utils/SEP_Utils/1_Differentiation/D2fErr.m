function [d2err] = D2fErr(h, x0, f)
% Berechnet den absoluten Fehler des D1f Verfahrens
% h:    Schrittweite
% x0:   Startwert
% f:    Funktion

% Vorraussetzungen
fDiff1  =  diff1(f);
d2f     =  D2f(h, x0, f);
%Kalkulation
d2err   =  abs( d2f - fDiff1(x0) );