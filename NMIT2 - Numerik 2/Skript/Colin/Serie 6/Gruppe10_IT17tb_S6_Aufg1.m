% Löst das Anfangswertproblem mit dem klassischen Runge-Kutta Verfahren
%
% PARAMETER
% f = die Funktion
% a,b = Intervall
% n = Anzahl Berechnungsschritte
% y0 = Anfangswert für f(a)
%
% RETURN
% x = xi Werte
% y = yi Werte
%
% SAMPLE
% [x,y] = Gruppe10_IT17tb_S6_Aufg1(@(x,y)x.^2 + 0.1 * y,-1.5,1.5,5,0)
function [x,y] = Gruppe10_IT17tb_S6_Aufg1(f,a,b,n,y0)
    % h berechnen
    h = (b - a) / n;
    
    % Vektoren x und y initialisieren
    x = a:h:b;
    lenX = length(x);
    y = zeros(1, lenX);
    y(1) = y0;
    
    for i=1:lenX-1
        k1 = f(x(i), y(i));
        k2 = f((x(i)+h/2),(y(i)+(h/2)*k1));
        k3 = f((x(i)+h/2),(y(i)+(h/2)*k2));
        k4 = f((x(i)+h),(y(i)+h*k3));
        x(i+1) = x(i)+h;
        y(i+1) = y(i) + h * (1/6) * (k1 + 2*k2 + 2*k3 + k4);
    end
end

