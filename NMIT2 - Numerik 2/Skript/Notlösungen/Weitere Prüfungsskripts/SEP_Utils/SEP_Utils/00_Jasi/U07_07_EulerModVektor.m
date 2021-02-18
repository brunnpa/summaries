% Funktion und Startwerte eingeben
f = @(x, y) [y(2),2*x-cos(y(1))*x^2];
a = 1;
b = 10;
n = 18;
y0 = [2; -1];

[x,y] = eulerModifiziertV(f, a, b, n, y0);
plot(x,y(:,1))
hold on


% --------------------------------------------
% Modifiziertes Euler-Verfahren für Vektoren
% f = Differenzialgleichungen
% a = Startwert
% b = Endwert
% n = Anzahl Schritte
% y0 = Startwerte
% Rückgabewerte:
% (xi, yi) = n - berechnete Punkte der Funktion
% Aufruf:
% [x,y] = eulerModifiziertV(@(x, y) [y(2),2*x-cos(y(1))*x^2], -1.5, 1.5, 18, [2; -1])
% --------------------------------------------
function [x, y] = eulerModifiziertV(f, a, b, n, y0)
    h = (b-a)/n;

    x = zeros(n+1, 1);
    y = zeros(n+1, 2);

    y(1,:) = y0;
    x(1) = a;

    for i=1:n
        k1 = f(x(i), y(i,:));
        yEuler = y(i,:) + h *  k1;
        x(i+1) = x(i) + h;
        k2 = f(x(i+1), yEuler);
        y(i+1,:) = y(i,:) + h * (k1+k2)/2;
    end
end