function    [IRf]   =   RfSum(a, b, f, n)
% Test:     [IRf]   =   RfSum(2, 4, @(x) 1/x, 4)
% Result:           =   0.691219891219891
% Zweck: Integrationsberechnung anhand der Rechteck-Regel
% Params:
% a:    Untere Integrationsgrenze
% b:    Obere Integrationsgrenze
% f:    Zu integrierende Funktion
% n:    Anzahl Subintervalle
%
% Algorithmus:
% Nicht so Optimal da man an den linken intervallgrenzen eine konstanten
% annimmt (Treppenstufen).
% 1)    Ersetzen von f(x) auf dem Intervall [a,b] durch eine Konstante

if (b <= a)
    error("b muss als obere Intervallgrenze grösser als a sein")
end

IRf = 0;

% Bestimmung der Schritgrösse
h   = (b-a) / n; % Intervallgrösse durch gewünsche Subintervall Anzahl

x = zeros(1,n+1);
x(1) = a;

for i = 2:n+1
    x(i) = x(i-1) + h;
end

for i = 1:n
    IRf = IRf + f(x(i) + ( h/2 ));
end

RfSum = IRf .* h;     % Zum Schluss Multiplikation mit h

