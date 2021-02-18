function    [ISf]   =   SfSumIterative(a, b, f, n)
% Test:     [ISf]   =   SfSumIterative(2, 4, @(x) 1/x, 4)
%                   =   0.693154530654531
% Zweck: Integrationsberechnung anhand der Summierten Simpson-Regel
%        Implementation jedoch durch iteratives Aufrufen der 
%        Simpson Formel und Aufsummieren der Subintervalle
% Params:
% a:    Untere Integrationsgrenze
% b:    Obere Integrationsgrenze
% f:    Zu integrierende Funktion
% n:    Anzahl Subintervalle
% Algorithmus:
% 1)    Erzeugung von Subintervallen
% 2)    Wiederholtes Anwenden der elementaren Simpson-Funktion
% 3)    Aufsummieren der Sub-Integrale

% Check
if (b <= a)
    error("b muss als obere Intervallgrenze grösser als a sein")
end

% Hilfsgrössen
h   =   ((b - a) / n);  % Halbe Intervallbreite da 2 Schritte

% Startpunkt linke Intervallgrenze
x0  = a;
ISf = 0;

% Iterationsschritte
for i = 1:n
        x_right     = x0 + h;           % rollierende Intervallgrenze
    subIntegral = Sf(x0, x_right, f);
    ISf         = ISf + subIntegral;
    x0          = x_right;           % neue Integralgrenze
end

ISf = ISf;