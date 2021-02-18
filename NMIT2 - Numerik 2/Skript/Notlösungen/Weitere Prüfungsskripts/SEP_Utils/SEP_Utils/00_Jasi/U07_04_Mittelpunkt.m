% Funktion und Startwerte eingeben
f = @(t, yt) t.^2 + 0.1 * yt;
a = -1.5;
b = 1.5;
n = 5;
y0 = 0;

[x,y] = eulerMittelpunkt(f, a, b, n, y0);
plot(x,y)

hold on
% Exakte Kurve zeichnen
fExakt = @(t) -10.*t.^2 - 200.* t - 2000 + 1722.5 .*exp(0.05.*(2.*t+3));
int = a:0.01:b;
plot(int, fExakt(int));
hold off

% lokaler Fehler:
errLok = fExakt(x(1)) - y(1)

% globaler Fehler
errGlob = fExakt(x(end)) - y(end)

% Konsistenz & Konvergenz Ordnung 2 (S.121)


% --------------------------------------------
% Mittelpunkt-Verfahren
% f = Differenzialgleichung
% a = Startwert
% b = Endwert
% n = Anzahl Schritte
% y0 = Startwert
% Rückgabewerte:
% (xi, yi) = n - berechnete Punkte der Funktion
% Aufruf:
% [x,y] = eulerMittelpunkt(@(t, yt) t.^2 + 0.1 * yt, -1.5, 1.5, 5, 0)
% --------------------------------------------
function [x, y] = eulerMittelpunkt(f, a, b, n, y0)
    h = (b-a)/n;
    
    x = zeros(n+1, 1);
    y = zeros(n+1, 1);

    y(1) = y0;
    x(1) = a;

    for i=1:n
       xHalb = x(i) + (h/2);
       yHalb = y(i) + (h/2) * f(x(i), y(i));
       x(i+1) = x(i) + h;
       y(i+1) = y(i) + h *  f(xHalb, yHalb);
    end
end