clc;
clear;

%% Deklaration und Initalisierung

a = 0;
b = 50 * 10 ^(-3);

t = a:10^(-3):b;   % 0 - 50 milliseunden in 1ms Schritten
R = 50;                     % Wiederstand in Ohm
n = 3;                      % Schritte Romberg
V = @(t) 3500 * sin(140 .* pi .* t) .* exp(-63 .* pi .* t);
E = @(t) V(t).^2 / R;     

%% a) Berechnen sie die Funktion E(t) mittels Romberg-Extrapolation

% Berechnung (V wurde eingehängt in E bereits bei Definition von E)
for i=1:size(t,2)
    D = Romberg(a,t(i),E,n);
    E_r3(i) = D(1,n);
end

n = 6;
for i=1:size(t,2)
    D = Romberg(a,t(i),E,n);
    E_r6(i) = D(1,n);
end

hold on;
plot(t,E_r3, 'r', t, E_r6,'b');
legend('E mit n=3', 'E mit n=6');

% Plotten

figure(1);
plot(t, E_r3, "blue"); 
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

f       = @(t) E(t) - 250;
h       = [0.01, 0.005, 0.0025,0.00125];
epsilon = 1e-5;
xn      = 5e-3;            

% 1) f(t) aufstellen: Hier g genannt
g   = @(t) E(t) - 250;                 % Nullstellenproblem

while ((f(xn - epsilon) * f(xn + epsilon)) > 0) 
    %Ableitung
    fdiff =  h2Extrapolation(xn, h, f, "D2f" );
    %Newton Verfahren
    xn1 = xn - (f(xn)/fdiff(1,4));  % Zugriff auf die H
    xn = xn1; 
end


% Der Puls muss nach 0.010421 Sekunden abgestellt werden.
fprintf('Puls abschalten nach: %.6f Sekunden\n', xn);
disp(xn);
disp(f(xn));

