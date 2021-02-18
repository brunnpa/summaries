function [ITf]  =   TfSum(a, b, f, n)
% 
% Zweck: Integrationsberechnung anhand der 
% summierten Trapez-Regel
% Params:
% a:    Untere Integrationsgrenze
% b:    Obere Integrationsgrenze
% f:    Zu integrierende Funktion
% n:    Anzahl Subintervalle
%
% Algorithmus:
% !     Ersetzen von f(x) durch ein Polynom 1. Grades (Konstanze)
% 1)    Aufteilung in n Subintervalle
% 2)    Iterative Anwendung der Trapez-Regel auf die Subintervalle

% Check
if (b <= a)
    error("b muss als obere Intervallgrenze grösser als a sein")
end

% Bestimmung der Schritgrösse
h   = (b-a) / n; % Intervallgrösse durch gewünsche Subintervall Anzahl
xi  = a;         % Erstes Intervall

ITf = ((f(a) + f(b)) / 2);

for i=1:n-1
    ITf = ITf + (f(xi + i * h));
end

TfSum = ITf * h;


