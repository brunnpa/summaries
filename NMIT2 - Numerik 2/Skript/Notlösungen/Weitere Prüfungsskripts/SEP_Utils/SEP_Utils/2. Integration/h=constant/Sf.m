function    [ISf]   =   Sf(a, b, f)
% Test:     [ISf]   =   Sf(2, 4, @(x) 1/x)
%                   =   0.694444444444444
% Zweck: Integrationsberechnung anhand der Simpson-Regel
%        anhand von 3 Punkten (a, b, Mittelpunkt des Intervalles)                         
% Params:
% a:    Untere Integrationsgrenze
% b:    Obere Integrationsgrenze
% f:    Zu integrierende Funktion
% n:    Anzahl Subintervalle
%
% Algorithmus:
%   Nicht so Optimal da man an den linken intervallgrenzen eine konstanten
%   annimmt (Treppenstufen).
% 1)    Ersetzen von f(x) auf dem Intervall [a,b] 
%       durch ein polynom 2. Grades
% 2)    Approximation des Integrals an 3 Stellen (2 Subintervalle)

% Check
if (b <= a)
    error("b muss als obere Intervallgrenze grösser als a sein")
end

% Hilfsgrössen
m   =   ((b + a) / 2);  % Mittelpunkt Intervall
h   =   ((b - a) / 2);  % Halbe Intervallbreite da 2 Schritte
% Berechnung Polynomstellen
x1  =   a;
x2  =   m;
x3  =   b;

% Anwendung Simpsonregel
ISf = h/3 * (f(a) + 4*f(m) + f(b));
