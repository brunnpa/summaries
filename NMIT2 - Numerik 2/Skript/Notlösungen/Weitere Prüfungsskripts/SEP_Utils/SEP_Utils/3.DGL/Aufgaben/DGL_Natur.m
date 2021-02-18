%% RK vs Euler + Plot

clc;
clear;
% Voraussetzungen
% ----------------
% Teilaufgabe 1)
% ----------------
% * Im Intervall 0:4000:24000 h(t) berechnen
% * Formel: d(h) / d(t) = xxxxxxx
% ----------------
a = 0;
b = 24000;
d_t = 4000;  % Schrittweite h
n = (b - a) / d_t;

t = 0:d_t:24000;

g = 9.81;
R = 0.02;   % Radius
r = 0.02;   % klein Loch Radius
f = @(t,h) ((-1)*(((r^2)*sqrt(2*g*h)) / ((2*h*R) - h^2)));

y0 = 6.5;

[x,y_runge] = rk4(f, a, b, n, y0);

% ----------------
% Teilaufgabe 2)
% ----------------
% * Ebenfalls mit Euler, Mittel und ModEul
% ----------------
[x_euler, y_euler]        = euler(f, a, b, n, y0);
[x_mittel, y_mittelpunkt]  = mittelpunkt(f, a, b, n, y0);
[x_modeuler, y_modeuler]     = modeuler(f, a, b, n, y0);
% ----------------
% Teilaufgabe 3)
% ----------------
% *Plotten
% ----------------
hold on;
plot(x_euler, y_euler, 'g');
plot(x_mittel, y_mittelpunkt, 'r');
plot(x_modeuler, y_modeuler, 'm');
plot(x, y_runge, 'b');
legend('klassisch', 'mittelpunkt', 'modifiziert',"runge");
hold off;
%% RK vs Euler + Plot
% SERIE 6 AUFGABE 3
clc;
clear;
% Voraussetzungen

% ----------------
a = 0;
b = 10;
d_x = 0.1;  % Schrittweite h
n = (b - a) / d_x;

x = 0:d_x:b;

f = @(x,y) x^2 / y;

y_exact = @(x) (sqrt ((2 * x.^3)/3) + 4);

y0 = 2;

[x,y_runge]     = rk4(f, a, b, n, y0);
[~,y_euler]     = euler(f, a, b, n, y0);
[~,y_mittel]    = mittelpunkt(f, a, b, n, y0);
[~,y_modeuler]  = modeuler(f, a, b, n, y0);

y_exact = y_exact(x);

err_runge       = abs(y_runge - y_exact);
err_euler       = abs(y_euler - y_exact);
err_mittel      = abs(y_mittel - y_exact);
err_modeuler    = abs(y_modeuler - y_exact);

hold on;
semilogx(x, y_euler, 'g');
semilogx(x, y_mittel, 'r');
plsemilogxot(x, y_modeuler, 'm');
semilogx(x, y_runge, 'b');
legend('err_klassisch', 'err_mittelpunkt', 'err_modifiziert',"err_runge");
hold off;


