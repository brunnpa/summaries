% NEWTON-VERFAHREN FÜR MEHRDIMENSIONALE MATRIZEN
%
% INPUT
% startVektor = der Startvektor
% tolerance = die Toleranz
%
% OUTPUT
% nextX = die Nullstelle
%
% BEISPIELAUFRUF
% [nextX] = V_nLGS_NewtonVerfahrenFuerSysteme_brunnpa7([4,2], 10^(-4))
function [nextX] = Aufgabe6b_NewtonVerfahrenFuerSysteme_brunnpa7

format long g

tolerance = 10^-6;

% Startvektor definieren
x0 = [0;0];
x = x0;

% Anzahl Iterationen festlegen
n = 1;

% Variablen definieren
syms a b

% Funktion definieren
f = [
    (a.^2 + b.^2 -1);
    (a - b.^2);
    ];

% Jacobi Matrix berechnen. Der 2. Parameter muss ein Vektor von Variablen sein!
D = jacobian(f, [a b]);
disp("Die Jacobi Matrix ist:")
D

% Delta definieren
delta = - ( inv(D) * f);
disp("Das Delta ist: ");
delta



% Newton-Verfahren durchführen
for i= 1 : 1 : n
    % a, b, c initialisieren für Newton-Verfahren
    a = x(1);
    b = x(2);
    
    % x(n+1) berechnen (wird der Einfachheit halber immer nur im gleichen
    % Vektor x gespeichert. 
    disp(['Das ist die ', num2str(i) , '. Iteration für Newton:']);
    
    % Rechenschritt für f(a, b, c) ausgeben
    disp('Die numerische Lösung für f(a,b,c) ist:');
    fEval = eval(f);
    fEval
    
    % Rechenschritt für Jacobi-Matrix ausgeben
    disp('Die numerische Lösung für die Jacobi-Matrix Df(a,b,c) ist:');
    DEval = eval(D);
    DEval
    
    % Rechenschritt für Delta ausgeben
    disp('Die numerische Lösung für das Delta ist:');
    deltaEval = eval(delta);
    deltaEval
    
    disp(["Das x der:", num2str(i), 'lautet: ']);
    x = eval(x + delta)
end

disp("Das Endresultat für x ist:");
x
end

