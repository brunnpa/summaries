function [d3f]  =   d3f(h, x0, f)
% d1f = example
% Berechnet die Ableitung an der Stelle x0
% mittels Rückwärtsdiferenz
% Fehlerordnung O(h^1), k = 1
%
% x0: Stelle, an der die Ableitung berechnet wird
% h : Schrittweite
% f : Funktion

d3f = (f(x0) - f(x0 - h)) / (h);