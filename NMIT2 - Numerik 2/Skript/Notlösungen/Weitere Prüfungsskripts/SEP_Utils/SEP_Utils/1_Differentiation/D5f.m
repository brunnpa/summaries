function [d5f]  =   D5f(h, x0, f)
% d5f = example
% Berechnet die 2. Ableitung an der Stelle x0
% mittels Zentraldifferenz
% Fehlerordnung O(h^1), k = 1
%
% x0: Stelle, an der die Ableitung berechnet wird
% h : Schrittweite
% f : Funktion

d5f     =   (( f(x0 + h) - 2*f(x0) + f(x0 - h) ) / h^2 );