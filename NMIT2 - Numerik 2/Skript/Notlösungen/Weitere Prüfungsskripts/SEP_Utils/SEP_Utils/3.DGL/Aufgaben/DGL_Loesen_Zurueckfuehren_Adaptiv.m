%% DGL Zur�ckf�hren + Euler-Verfahren + Runge-Kutta
clc; clear;
% a)    y4 + 1.1y3 - 0.3y = sin(x) + 5
% Notizen:
%   4 z Variablen da 4 Ableitungen
% Voraussetzungen

y0 = [0;2;0;0];    % b = 2 da z0
x0 = 0;
a = x0;
b = 2;

A = [0,1,0,0;0,0,1,0;0,0,0,1;0.3,0,0.1,-1.1];

f  = @(x,z) A*z + [0;0;0;sin(x)+5];  % B muss ausgeschrieben werden 

% h = 0.1 => n = 20      da n = (b - a) / 2
n = 20;

% 1) L�sung mit Euler
[x, y] = euler(f, a, b, n, y0);
clf;

plot(x, y(2,:));
plot(x, y(3,:));

%% Fadenpendel Winkel l�sen mit RK
% !!! Serie 8 Aufgabe 2
clc; clear;

% Voraussetzungen

c = 0.16;
l = 1.2;
g = 9.81;
m = 1;

a = 0;              % Intervallgrenzen
b = 60;
h = 0.1;
n = (b - a) / h;


phi = @(t, z)[z(2); -c/m * z(2) - g/1 * sin(z(1))];  % z(2) = 1 ableitung
phi0 = [pi/2; 0];        % Aus Bedingung

a = 0;
b = 60;
h = 0.1;
n = abs(b-a) / h;

% Ausrechnen der x-y Koordinaten mittels dem Eulerverfahren

[t, y] = rk4(phi, a, b, n, phi0);

plot(t,y(1,:), 'r');
title('Fadenpendel integriert mit Runge-Kutta');
legend('Auslenkwinkel des Fadenpendels');
ylim([-2 2]);


%% Mittelpunkt adaptiver Schrittweitensteuerung
% Serie 8 Aufgabe 3

a = 0;
b = 10;
h = 0.01;
n = (b-a)/h;

x0 = 0;
y0 = 0;

f       = @(t, y) -12*y + 30 * exp(-2 * t);
f_exact = @(t) 3 * (1 - exp(-10*t)) * exp(-2*t);

% a) Euler + Mittelpunkt fixes h

[t, yeuler] = euler(f, a, b, n, y0);
[~, ymitel] = mittelpunkt(f, a, b, n, y0);

% b) Schrittweite Adaptiv

TOL = 1e-1;
h_A = [h];
t_A = [a];
y_k_mittel = [0];
y_euler = [0];

k = 1;
while (t_A(k) < b)
    % Ein Schritt Mittelpunktregel
    k1 = f(t_A(k),y_k_mittel(k));
    k2 = f(t_A(k)+h_A(k)/2,y_k_mittel(k)+h_A(k)/2 * k1);
    
    y_k_mittel(k+1) = y_k_mittel(k)+h_A(k) * k2;
    t_A(k+1) = t_A(k)+h_A(k);
    
    % Ein Schritt Euler
    y_euler(k+1)= y_k_mittel(k) + h_A(k)*k1; 

    % Schrittweite anpassen?
    if(abs(y_k_mittel(k+1) - y_euler(k+1))< (TOL/20))
        h_A(k+1) = 2*h_A(k);
        k = k+1;
        continue;
    end

    % Schrittweite verkleiner
    if(abs(y_k_mittel(k+1)-y_euler(k+1))>= TOL)
        h_A(k) = h_A(k)/2;
        continue;
    end
    % Schritt gültig ohne Schrittweitensteuerung
    h_A(k+1) = h_A(k);
    k = k+1;
end

% Aufgabe c
% Plotten des Diagrammes
subplot(2,1,1);
plot(t_A,y_k_mittel, t_A,f_exakt(t_A));
legend('genäherte Lösungskurve','exakte Lösung');
xlabel('Zeitpunkt t');
ylabel('Wert');

subplot(2,1,2);
plot(t_A,h_A);
legend('variable Schrittweite');
xlabel('Zeitpunkt t');
ylabel('Wert');

% Aufgabe d
fprintf('Aufgabe d: Ob h gross oder klein gewählt wird, spielt keine Rolle. Das Diagramm der Schrittweite zu den Zeitpunkten (t) sieht immer gleich aus \n');
fprintf('Aufgabe d: Wird die Toleranz zu gross gewählt, so schwankt die Kurve öfters. Die Annäherung passt jedoch trotzdem');      