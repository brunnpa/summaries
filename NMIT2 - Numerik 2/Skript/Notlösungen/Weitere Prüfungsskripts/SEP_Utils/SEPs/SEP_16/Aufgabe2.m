% Funktion und Startwerte eingeben
f = @(t, yt) 0.1*yt + sin(2*t);
a = 0;
b = 6;
h = 0.2;
n = (b-a)/h;
y0 = 0;

[xE, yE] = eulerKlassisch(f,a,b,n,y0);
[xR, yR] = runge_kutta(f,a,b,n,y0);

subplot(2,1,1);
plot(xE,yE,xR,yR);
legend('Euler klassisch', 'Runge-Kutta');

subplot(2,1,2);
diff = abs(yE-yR);
semilogy(xE,diff);



% --------------------------------------------
% Klassisches Euler-Verfahren
% f = Differenzialgleichung
% a = Startwert
% b = Endwert
% n = Anzahl Schritte
% y0 = Startwert
% Rückgabewerte:
% (xi, yi) = n - berechnete Punkte der Funktion
% Aufruf:
% [x,y] = eulerKlassisch(@(t, yt) t.^2 + 0.1 * yt, -1.5, 1.5, 5, 0)
% --------------------------------------------
function [x, y] = eulerKlassisch(f, a, b, n, y0)
    h = (b-a)/n;

    x = zeros(n+1, 1);
    y = zeros(n+1, 1);

    y(1) = y0;
    x(1) = a;

    for i=1:n
       x(i+1) = x(i) + h;
       y(i+1) = y(i) + h *  f(x(i), y(i));
    end
end

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