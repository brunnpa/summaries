clc;
clear;

%% Deklaration und Initalisierung

a = 0;
b = 50 * 10 ^(-3);

t = a:10^(-3):b;   % 0 - 50 milliseunden in 1ms Schritten
R = 50;                     % Wiederstand in Ohm
n = 3;                      % Schritte Romberg
V = @(t) 3500 * sin(140 * pi * t) * exp(-63 * pi * t);
f = @(t) V(t).^2/R;         
                      

integralRomberg = @(a, b, f, m) Romberg(a,b,f,m); 


Et = @(t) integralRomberg(a,t, f, n); % Integrationsschritt

%% a) Berechnen sie die Funktion E(t) mittels Romberg-Extrapolation

% Berechnung
for i = 1:length(t)
    E_array(i) = f(t(i)); 
    V_array(i) = V(t(i));
end

% Plotten

figure(1);
plot(t, E_array, "blue"); 
title("Aufgebrachte Energie für Defibrilator"); legend("E(t)");
xlabel("Sekunden"); ylabel("E [Joule]");

%% b) Nullstellenproblem lösen
% Nullstelenproblem:
%  * Newton Verfahren:
%       * Findet Nullstellen nährungsweise
%       * Tangente wird bestimmt (linearisierung)
%       * Nullstelle der Tangente als Nährung der Nullstelle der Funktion
%       * Nährung wird stetig verbessert bis Schranke unterschritten ist
%
%       1) Funktion aufstellen
%       2) Funktion des Nullstllenproblemes aufstellen
%       3) Abbruchbedingung in While
%
%       4) In While Schleife Ableitung abhöngg von 
%           %       !!! Spezifisch wegen H 2 algo:
%           % tn    = x0;
%           % h     = h0;

% Ableiten mit h2 algo

ti  = 0.01;  % tn ist gleich die Schrittweite
h   = 0.01;
tol = 10^-5;    % Abbruchbedingung e
f   = @(t) V(t).^2/R;     % Funktion die integriert werden muss um auf E(t)
                          % zu kommen (von oben)


% 0) E(t) aufstellen (war bereits oben) mittels Romberg
Et  = @(t) integralRomberg(a, t, f, n); % Tatsächliche integration
% 1) f(t) aufstellen: Hier g genannt
g   = @(t) Et(t) - 250;                 % Nullstellenproblem


while((g(ti - tol) * g(ti + tol)) > 0)    % 3) Abbruchbedingung
    dg = h2Extrapolation(ti, h, f, "D2f");  % Ableiten an stelle ti dg(n)
    ti = ti - (g(ti) / dg);
end