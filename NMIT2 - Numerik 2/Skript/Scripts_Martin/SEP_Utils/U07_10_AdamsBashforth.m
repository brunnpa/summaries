% Ordnung
ordnung = 4;
f = @(t,yt)yt; % gew�nschte Funktion
a = 0; % Startwert
b = 3; % Endwert
n = 4; % Anzahl Schritte
y0 = 0; % Startwert

s = ordnung -1;
bKoeff = zeros(s+1,1);

% Koeffizienten b berechnen
for idx = 1:s+1
    j = idx -1;

    % Funktion im Integral erstellen und integrieren
    syms u
    uf = 1;
    for idx2 = 1:s+1
       k = idx2-1;
       if (k ~= j)
           uf = uf * (u+ k);
       end
    end
    uf = matlabFunction(uf,'vars',u);
    ufInt = integral(uf, 0,1);
    
    bKoeff(idx) = (-1)^j / (factorial(j) * factorial(s-j)) * ufInt;
end
% Adams Bashforth nun l�sen
% Vektoren initialisieren
y = zeros(n+1, 1);
x = zeros(n+1, 1);

% Hilfsvektor, damits optimiert ist
f_val = zeros(n+1, 1);

% h berechnen
h = (b-a)/n;

% Erste n startwerte mit 4 Stufigem Runge-Kutta berechnen (entspricht der Ordnung)
[x(1:ordnung), y(1:ordnung)] = runge_kutta(f,a,a + (s*h),s,y0);
f_val(1:4) = f(x(1:4), y(1:4));

% Restliche Werte berechnen
for i = ordnung:(n+1)
    x(i+1) = x(i) + h;
    value = 0;
    for j = 1:s+1
        value = value + (bKoeff(j) * f_val(i-(j-1)));
    end
    y(i+1) = y(i) + h * value;
    f_val(i+1) = f(x(i+1), y(i+1));
end
disp(y)


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

