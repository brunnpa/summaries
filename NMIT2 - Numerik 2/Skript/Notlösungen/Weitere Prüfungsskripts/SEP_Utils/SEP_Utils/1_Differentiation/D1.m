function [d1] = D1(h, x0,y0, f)
% d1 = example
% Berechnet die Ableitung an der Stelle x0
% mittels Vorwärtsdifferenz
% Fehlerordnung O(h^1), k = 1
%
% x0: Stelle, an der die Ableitung berechnet wird
% y0: Stelle, dan der die Ableitung berechnet wird
% h : Schrittweite
% f : Funktion

format long;

d1 = ( (f(x0 + h, y0) - f(x0, y0))   /  h );
