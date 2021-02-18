function    [x, yab4]     =   adams4(f, a, b, n, y0)
% Test:     [x, yab4]     =   adams4((@(x,y)x.^2+0.1*y),-1.5,1.5,10,1)
%
% Methode, die mittels des Adam Bashford Mehrschrittvefahrens
% welches ein Polynom an den vorgegebenen Punkten interpoliert.

% Params:
% f:    Zu integrierende Funktion
% a:    Untere Intervallgrenze
% b:    Obere Intervallgrenze
% n:    Schrittanzahl für Integration
% y0:   Startwert
% s:    Stufigkeit der Adams-B Methode
% 
% Returns:
% b:    Koeffizienten

%% Vorraussetzungen
h       = (b - a) / n;         fprintf("h =  %.4f", h);
y = zeros(n+1, 1);
x = zeros(n+1, 1);
f_val = zeros(n+1, 1);

%% Erste 4 Startwerte berechnen
[x(1:4), y(1:4)] = rk4(f, a, a + 3*h, 3,y0);
f_val(1:4) = f(x(1:4), y(1:4));

%% Berechnung der 1. 4 Terme für Ordnung 4
for i=4:(n+1)
    x(i+1) = x(i) + h;
    y(i+1) = y(i) + h/24 * (55*f_val(i) - 59*f_val(i-1) + 37 * f_val(i-2) - 9*f_val(i-3));
    f_val(i+1) = f(x(i+1), y(i+1));
end

yab4 = y;
end

