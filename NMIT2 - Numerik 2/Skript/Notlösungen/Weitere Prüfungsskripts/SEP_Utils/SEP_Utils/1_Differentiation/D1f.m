function [d1f] = D1f(h, x0, f)
% d1f = example
% Berechnet die Ableitung an der Stelle x0
% mittels Vorwärtsdifferenz
% Fehlerordnung O(h^1), k = 1
%
% x0: Stelle, an der die Ableitung berechnet wird
% h : Schrittweite
% f : Funktion

format  long;

d1f = (f(x0+h) - f(x0)) / h;