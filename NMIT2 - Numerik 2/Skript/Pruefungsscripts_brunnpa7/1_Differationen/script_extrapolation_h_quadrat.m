clc;
format long;

% ====================================================================== %
% Script: h^2-Extrapolation
%
% Beschreibung:
% In diesem Script werden die gesuchten d-Werte sowie die zugehoerigen
% e-Werte mittels h^2-Extrapolation ermittelt
% ====================================================================== %



% ================================================== %
% TODO: Werte nach Bedarf anpassen                   %
% ================================================== %

% Anzahl der Berechnungen
n = 4;

% Schrittweite
h0 = 0.1;

% Startwert
x0 = 2;

% Stammfunktion
f = @(x) log(x^2); 

% 1. Ableitung
fDiff = @(x) 2/x;   % -> TODO ersetzen

% Zentraldifferenz Funktion
D2f = @(x0,h) (f(x0+h) - f(x0-h)) / (2*h); 

% ================================================== %


% Array fuer d-Werte
D = zeros(n);

% Array fuer veraenderte h-Werte (nur fuer Anzeige)
H = zeros(n,1);

% Array fuer e-Werte
E = zeros(n);

% Berechnung von 1. Spalte
for i = 1:n
    H(i) = h0/2^(i-1);
    D(i,1) = D2f(x0, H(i));
    E(i,1) = abs(D(i,1) - fDiff(x0));
end

% Berechnung von Spalte 2 bis Spalte n, 1. Spalte wurde bereits berechnet
for i = 2:n
    
    k = i-1;  % i-1 weil in Matlab Index bei 1 startet die Formel aber bei 0

    for j = 1:n - k
        % h^2 Extrapolation Formel
        D(j,i) = (4^k * D(j+1, i-1) - D(j, i-1)) / (4^k - 1);
        E(i,j) = abs(D(i,j) - fDiff(x0));
    end
end


fprintf('h-Werte:\n');
disp(H);

fprintf('\nD-Werte:\n');
disp(D);

fprintf('\nE-Werte:\n');
disp(E);




%   Resultat fuer: f = @(x) sin(x),   x0 = 1
%
%   h-Werte:
%   0.100000000000000
%   0.050000000000000
%   0.025000000000000
%   0.012500000000000

%   D-Werte:
%   0.539402252169760   0.540302193338656   0.540302305866464   0.540302305868139
%   0.540077208046432   0.540302298833476   0.540302305868113                   0
%   0.540246026136715   0.540302305428448                   0                   0
%   0.540288235605515                   0                   0                   0
