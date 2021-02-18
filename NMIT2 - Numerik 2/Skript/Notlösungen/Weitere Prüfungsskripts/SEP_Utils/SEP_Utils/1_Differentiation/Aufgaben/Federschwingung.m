% Berechnung der Auslenkung aufgrund der gedämpften Schwingung
%
% Gegeben:
% ti:   Zeitpunkt
% xi:   Ort 
%  n:   Anzahl Zeitintervalle
%
% Gesucht:
% x(t):     Auslenkung      bei t
% x'(t):    Geschwindigkeit bei t
% x''(t):   Beschleunigung  bei t

% Vorraussetzungen für die Berechnung
nMax    = 1000;         % Intervalle
n       = 1:nMax;       % Anzahl Messpunkte
t       = 0 + n .* 0.1; % Zeitpunkte

% Berechnung der Auslengung
xt      = 10 .* exp(-0.05 .* t) .* cos(0.2 .*pi .*t); 

% Berechnung der Geschwindigkeit
vt      = D1fD2fD3fDiskret(t, xt);
% Berecnung der Beschleunigung
at      = D1fD2fD3fDiskret(t, vt);

% Plotten
plot(t, xt, t, vt, t, at);
legend("Ort", "Geschwindigkeit", "Beschleunigung");
grid();
