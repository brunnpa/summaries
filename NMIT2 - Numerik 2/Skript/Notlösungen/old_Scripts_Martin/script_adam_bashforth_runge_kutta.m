% Ordnung
ordnung = 4;
f = @(t,yt)yt; % gew�nschte Funktion
a = 0; % Startwert
b = 1; % Endwert
n = 10; % Anzahl Schritte
y0 = 1; % Startwert

% 
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
[x(1:ordnung), y(1:ordnung)] = func_runge_kutta(f,a,a + (s*h),s,y0);
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

for i = 1:length(y)
    fprintf('x: %.8f, y: %.8f\n', x(i), y(i));
end
