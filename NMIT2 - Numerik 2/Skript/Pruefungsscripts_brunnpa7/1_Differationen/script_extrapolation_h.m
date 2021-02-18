clc;
format long;

% ====================================================================== %
% Script: h-Extrapolation
%
% Beschreibung:
% In diesem Script werden die gesuchten d-Werte sowie die zugehoerigen
% e-Werte mittels h-Extrapolation ermittelt
% ====================================================================== %



% ================================================== %
% TODO: Werte nach Bedarf anpassen                   %
% ================================================== %

% Anzahl Berechnungen (n=4 -> 4 Spalten)
n = 4;

% Schrittweite
h = 0.1;

% Startwert x0
x0 = 2;

% Stammfunktion definieren
f = @(x) log(x^2);  % -> TODO ersetzen

% 1. Ableitung
fDiff = @(x) 2/x;   % -> TODO ersetzen

% Vorwaertsdifferenz Funktion
D1f = @(x0,h) (f(x0+h) - f(x0)) / h; 

% ================================================== %

% Array fuer d-Werte
D = zeros(n);

% Array fuer e-Werte
E = zeros(n);

% Array fuer veraenderte h-Werte (nur fuer Anzeige)
H = zeros(n, 1);


% Berechnung von 1. Spalte
for i = 1:n
    H(i) = h/2^(i-1);  % Berechnung von neuem h-Wert
    D(i,1) = D1f(x0, H(i));  % Berechnung von neuem d-Wert
    E(i,1) = abs(D(i,1) - fDiff(x0));  % Berechnung von neuem e-Wert
end


% Berechnung von Spalte 2 bis Spalte n, 1. Spalte wurde bereits berechnet
for i = 2:n
    
    k = i-1;  % i-1 weil in Matlab Index bei 1 startet die Formel aber bei 0
    
    % Spaltenberechnungen werden pro Zeile um 1 verringert (Treppenform)
    for j = 1:n - k
        % h-Extrapolation Formel
        D(j,i) = (2^k * D(j+1, i-1) - D(j, i-1)) / (2^k - 1);
        E(j,i) = abs(D(j,i) - fDiff(x0));
    end
end

fprintf('h-Werte:\n');
disp(H);

fprintf('\nD-Werte:\n');
disp(D);

fprintf('\nE-Werte:\n');
disp(E);
