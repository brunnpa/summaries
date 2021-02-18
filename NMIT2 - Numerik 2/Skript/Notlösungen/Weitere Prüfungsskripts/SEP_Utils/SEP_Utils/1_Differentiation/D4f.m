function [d4f]  =   D4f(h, x0, f)
% d4f = example
% Berechnet die 2. Ableitung an der Stelle x0
% mittels Vorwärtsdifferenz
% Fehlerordnung O(h^1), k = 1
%
% x0: Stelle, an der die Ableitung berechnet wird
% h : Schrittweite
% f : Funktion

d4f = (( f(x0 + 2*h) - 2*f(x0 + h) + f(x0) ) / h^2 );