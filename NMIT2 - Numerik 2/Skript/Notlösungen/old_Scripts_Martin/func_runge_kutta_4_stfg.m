
% Konsistenz & Konvergenz Ordnung 4 (S.122)

% --------------------------------------------
% Vierstufiges Runge Kutta Verfahren
% f = Differenzialgleichung
% a = Startwert
% b = Endwert
% n = Anzahl Schritte
% y0 = Startwert
% R�ckgabewerte:
% (xi, yi) = n - berechnete Punkte der Funktion
% Aufruf:
% [x,y] = func_runge_kutta_4_stfg(@(t, yt) t.^2 + 0.1 * yt, -1.5, 1.5, 5, 0)
% --------------------------------------------
function [x, y] = func_runge_kutta_4_stfg(f, a, b, n, y0)
    h = (b-a)/n;

    x = zeros(n+1, 1);
    y = zeros(n+1, 2);

    y(1,:) = y0;
    x(1) = a;

    for i=1:n
        k1 = f(x(i), y(i,:));
        k2 = f(x(i) + h/2, y(i,:) + h/2 * k1);
        k3 = f(x(i) + h/2, y(i,:) + h/2 * k2);
        k4 = f(x(i) + h, y(i,:) + h * k3);
        
       x(i+1) = x(i) + h;
       y(i+1,:) = y(i,:) + h *  (1/6) * (k1 + 2*k2 + 2*k3 + k4);
    end
end