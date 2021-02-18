function [IRf]  =   RfSumIterative(a, b, f, n)
% Test:  [IRf]  =   RfSumIterative(2, 4, @(x)1/x, 4)
% Result:       =   0.691219891219891
% Zweck: Integrationsberechnung anhand der Summierten Rechteck-Regel
% Params:
% a:    Untere Integrationsgrenze
% b:    Obere Integrationsgrenze
% f:    Zu integrierende Funktion
% n:    Anzahl Subintervalle

% Check
% Check
if (b <= a)
    error("b muss als obere Intervallgrenze grösser als a sein")
end
% Berechnung Intervallbreite
h   = ((b - a) / n);
% Startpunkt linke Intervallgrenze
x0  = a;
IRf = 0;

% Iterationsschritte
for i = 1:n
    x_right     = x0 + h;           % rollierende Intervallgrenze
    subIntegral = Rf(x0, x_right, f);
    IRf         = IRf + subIntegral;
    x0          = x_right;           % neue Integralgrenze
end

IRf = IRf;