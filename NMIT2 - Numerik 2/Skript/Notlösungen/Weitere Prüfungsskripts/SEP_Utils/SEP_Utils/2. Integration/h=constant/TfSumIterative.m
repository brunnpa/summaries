function [ITf]  =   TfSumIterative(a, b, f, n)
% Test:  [ITf]  =   TfSumIterative(2, 4, @(x)1/x, 4)
% Result:       =   0.697023809523809
% Zweck: Integrationsberechnung anhand der Summierten Trapez-Regel
% Params:
% a:    Untere Integrationsgrenze
% b:    Obere Integrationsgrenze
% f:    Zu integrierende Funktion
% n:    Anzahl Subintervalle

% Check
if (b <= a)
    error("b muss als obere Intervallgrenze grösser als a sein")
end
% Berechnung Intervallbreite
h   = ((b - a) / n);
% Startpunkt linke Intervallgrenze
x0  = a;
ITf = 0;

for i = 1:n
    x_right     = x0 + h;           % rollierende Intervallgrenze
    subIntegral = Tf(x0, x_right, f);
    ITf         = ITf + subIntegral;
    x0          = x_right;           % neue Integralgrenze
end

ITf = ITf;