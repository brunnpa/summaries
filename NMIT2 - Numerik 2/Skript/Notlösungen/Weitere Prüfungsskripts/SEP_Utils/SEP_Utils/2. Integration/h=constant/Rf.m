function [IRf]  =   Rf(a, b, f)
% Test:  [IRf]  =   Rf(2, 4, @(x)1/x )
% Result:       =   0.666666666666667
% Zweck: Integrationsberechnung anhand der Rechteck-Regel
% Params:
% a:    Untere Integrationsgrenze
% b:    Obere Integrationsgrenze
% f:    Zu integrierende Funktion
%
% Algorithmus:
% Nicht so Optimal da man an den linken intervallgrenzen eine konstanten
% annimmt (Treppenstufen).
% 1)    Ersetzen von f(x) auf dem Intervall [a,b] durch eine Konstante
% !     Ersetzen von f(x) durch ein Polynom 0. Grades (Konstanze)
%       f (( a + b ) / 2) * (b - a)

% Integralbreite
h = (b - a);
% Rechteck Bildung
IRf = f( (a + b) / 2 ) * (b - a);