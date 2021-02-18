% Berechnung der Zeit aus gegebenem Wiederstand
% Wiederstand ist Abhängig von der Geschwindigkeit
% Geschwindigkeit ist abhängig von der Zeit
%
% Gegeben: 
% R(v):     -v* v^(1/2)
% m:        10 kg
% v(0):     20 m/s         Startgeschwindigkeit zum Zeitpunkt 0
%
% Gesucht:
% t:        Zeit, die das Teilchen braucht, um auf
%           5 m/s zu bremsen
%
% Vorgenen:
% 1) Stammfunktion bestimmen
% 2) Einsetzen der Geschwindigkeiten
% 3) Bestimmtes Integral ausrechnen: F(b) - F(a)
%
% 4) Numerische Lösungen errechnen
% 5) Fehler ausrechnen

%`!!!!!!!!! SERIE 2 AUFGABE 4

% a) Summierte Rechteckregel
% b) Summierte Trapezregel
% c) Summierte Simpsonregel
clear, clc, clf;
format long;
% Grundvoraussetzungen
% 1) Umformen: R(v)     = -v * sqrt(v)
%                       = -1 * v ^ (- 3/2)

% 2) Einsetzen von    m = 10 m/s
% 3) Einsetzen von m und R(v) in die Formel:
f = @(x) -10.* x.^-(3./2);

% Bestimmen der Stammfunktion
F = @(x) 20 .* x.^(-1/2);

% Einsetzen
%   v(t0)   =   20 m/s
%   v(t_x)  =    5 m/s
t = -1 * (F(20) - F(5));   % * -1 weil die Bremsung ja in negative Richtung zeigt


% Hilfsvariablen
v1  =   5;
v2  =   20;
n   =   5;

% Aufgabe a) Berechnung via summierter Rechteck-Regel
tRf = -RfSumIterative(v1, v2, f, n);
% Aufgabe b) Berechnung via summierter Trapez-Regel
tTf = -TfSumIterative(v1, v2, f, n);
% Aufgabe c) Berechnung via summierter Simpson-Regel
tSf = -SfSumIterative(v1, v2, f, n);

%Berechnung der Fehler
eRf     = abs(tRf - t);
eTf     = abs(tTf - t);
eSf     = abs(tSf - t);

disp(eRf);
disp(eTf);
disp(eSf);




