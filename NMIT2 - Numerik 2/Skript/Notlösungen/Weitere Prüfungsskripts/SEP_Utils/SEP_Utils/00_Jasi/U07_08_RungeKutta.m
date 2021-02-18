% Funktion und Startwerte eingeben
f = @(t, yt) t.^2 + 0.1 * yt;
a = -1.5;
b = 1.5;
n = 5;
y0 = 0;

[x,y] = runge_kutta(f, a, b, n, y0);
plot(x,y);

hold on
% Exakte Kurve zeichnen
fExakt = @(t) -10.*t.^2 - 200.* t - 2000 + 1722.5 .*exp(0.05.*(2.*t+3));
int = a:0.01:b;
plot(int, fExakt(int));
hold off

% Konsistenz & Konvergenz Ordnung 4 (S.122)

% --------------------------------------------
% Vierstufiges Runge Kutta Verfahren
% f = Differenzialgleichung
% a = Startwert
% b = Endwert
% n = Anzahl Schritte
% y0 = Startwert
% Rückgabewerte:
% (xi, yi) = n - berechnete Punkte der Funktion
% Aufruf:
% [x,y] = runge_kutta(@(t, yt) t.^2 + 0.1 * yt, -1.5, 1.5, 5, 0)
% --------------------------------------------
function [x, y] = runge_kutta(f, a, b, n, y0)
    h = (b-a)/n;

    x = zeros(n+1, 1);
    y = zeros(n+1, 1);

    y(1) = y0;
    x(1) = a;

    for i=1:n
        k1 = f(x(i), y(i));
        k2 = f(x(i) + h/2, y(i) + h/2 * k1);
        k3 = f(x(i) + h/2, y(i) + h/2 * k2);
        k4 = f(x(i) + h, y(i) + h * k3);
        
       x(i+1) = x(i) + h;
       y(i+1) = y(i) + h *  (1/6) * (k1 + 2*k2 + 2*k3 + k4);
    end
end