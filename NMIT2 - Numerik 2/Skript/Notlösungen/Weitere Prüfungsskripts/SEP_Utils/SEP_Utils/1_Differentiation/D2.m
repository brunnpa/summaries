function [d2] = D2(h, x0,y0, f)
% d22 = example
% Berechnet die Ableitung an der Stelle x0
% mittels Vorwärtsdifferenz
% Fehlerordnung O(h^2), k = 2
%
% x0: Stelle, an der die Ableitung berechnet wird
% y0: Stelle, dan der die Ableitung berechnet wird
% h : Schrittweite
% f : Funktion

format long;

d2 = ( (f(x0 + h, y0) - f(x0 - h, y0))   /  2*h );
