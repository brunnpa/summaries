%NEWTONVERFAHREN
format long
% Variablen aus Funktion
syms x      
% Funktion
f(x) = x^2 -2;      
% Maximale Anzahl Iterationen
n_max =30;     
% Auf wieviele Kommastrellen genau
nks = 4;           
% Startpunkt x0
x0 = 2;                 

% Ableitung berechnen
fStrich(x) = diff(f,x);
% xn initialisieren mit Startwert x0
xn = x0;
% n initialisieren mit 0
n = 0;
while (n <= n_max)
    % neuer Funktionswert fn berechnen
    fn = double(f(xn));
    % neuer Funktionswert für Ableitung berechnen
    fStrich_n = double(fStrich(xn));
    
    % x_n+1 berechnen
    x_n1 = (xn-(fn/fStrich_n));
    % Ausgabe
    disp(['   n                   xn']);
    disp([n xn]);
    % n++
    n = n+1;
    % xn übernimmt wert von x_n1
    xn = x_n1;
end