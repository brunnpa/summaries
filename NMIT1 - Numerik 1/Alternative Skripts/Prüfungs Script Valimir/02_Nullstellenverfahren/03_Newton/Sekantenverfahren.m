%SEKANTENVERFAHREN
format long
% Variablen aus Funktion
syms x     
% Funktion
f = @(x) (3060513257434037/1125899906842624)^x^2 - x^(-3) - 10;          
% Maximale Anzahl Iterationen
n_max =30;
% Auf wieviele Kommastrellen genau
nks = 4;
% 1. Startpunkt x0
x0 = -1; 
% 2. Startpunkt x1
x_n = -1.2;                 
% n initialisieren
n = 0;

while (n <= n_max)
    % Falls der absolute Wert von f(x) kleiner als 10^NACHKOMMASTELLE, 
    % dann terminiere die While-Schlaufe
    if(abs(f(x_n)) < 10^(-nks)) break;
    end;
    % Anzeige
    disp(['   n                   xn']);
    disp([n x0]);
    % Berechnung des Funktionswertes mit erstem Wert (x0)
    fn = double(f(x0));
    % Berechnung des Funktionswertes mit zweitem Wert (x1)
    fn1 = double(f(x_n));
    % Berechnung von x_n+1
    x_n1 = (x_n-((x_n-x0)/(fn1-fn))*fn1);
    % x0 (Wert1) nimmt Wert von xn an
    x0 = x_n;
    % x_n (Wert2) nimmt Wert von x_n+1 an
    x_n = x_n1;
    % n++
    n = n+1;
end
