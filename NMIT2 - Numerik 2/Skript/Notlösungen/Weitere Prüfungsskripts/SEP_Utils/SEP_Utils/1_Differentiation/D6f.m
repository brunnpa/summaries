function [d6f]  =   D6f(h, x0, f)
% d6f = example
% Berechnet die 2. Ableitung an der Stelle x0
% mittels Rückwärtsdifferenz
% Fehlerordnung O(h^1), k = 1
%
% x0: Stelle, an der die Ableitung berechnet wird
% h : Schrittweite
% f : Funktion

d6f     =   (( f(x0) - 2*f(x0 - h) + f(x0 - 2*h) ) / h^2 );