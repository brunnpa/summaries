% Funktion und Startwerte eingeben
U = 100;
L =1;
R = 80;
C = 4*10^(-4)
f = @(x, z) [y(2),(U/L)-(R/L)*y(2)-(1/C*L)*y(1)];
a 
y0 = [0,0];

[x,y] = eulerMittelpunktV(f, a, b, n, y0);
plot(x,y(:,1))
hold on


% --------------------------------------------
% Mittelpunkt-Verfahren für Vektoren
% f = Differenzialgleichungen
% a = Startwert
% b = Endwert
% n = Anzahl Schritte
% y0 = Startwerte
% Rückgabewerte:
% (xi, yi) = n - berechnete Punkte der Funktion
% Aufruf:
% [x,y] = eulerMittelpunktV(@(x, y) [y(2),2*x-cos(y(1))*x^2], -1.5, 1.5, 18, [2; -1])
% --------------------------------------------
function [x, y] = eulerMittelpunktV(f, a, b, n, y0)
    h = (b-a)/n;
    
    x = zeros(n+1, 1);
    y = zeros(n+1, 2);

    y(1,:) = y0;
    x(1) = a;

    for i=1:n
       xHalb = x(i) + (h/2);
       yHalb = y(i,:) + (h/2) * f(x(i), y(i,:));
       x(i+1) = x(i) + h;
       y(i+1,:) = y(i,:) + h *  f(xHalb, yHalb);
    end
end