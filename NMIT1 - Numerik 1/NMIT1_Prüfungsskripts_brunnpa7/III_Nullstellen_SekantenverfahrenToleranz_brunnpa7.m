% SEKTANTENVERFAHREN WELCHES NACH GEGEBENER TOLERANZ-ABBRICHT
% Reminder: Das Sekantenverfahren ist sehr ähnlich zum Newton-Verfahren mit
%
% INPUT:
% Als Input braucht das Sekantenverfahren jeweils zwei Startpunkte
% x0 = 1. Startpunkt 
% x1 = 2. Startpunkt
%
% OUTPUT:
% n = Iterationsschritt
% xn = Näherungswert durch Sekantenverfahren
%
%
% BEISPIELAUFRUF:
% III_Nullstellen_SekantenverfahrenToleranz_brunnpa7

function III_Nullstellen_SekantenverfahrenToleranz_brunnpa7
% Format definieren
format long
% Variablen aus Funktion
syms x     

% Funktion definieren
f = @(x) x^2-1;          
% Auf wieviele Kommastrellen genau
tol = 0.1;
% 1. Startpunkt x0
x0 = -0.5; 
% 2. Startpunkt x1
x_n = 3;                 
% n initialisieren
n = 0;

while (1)
    % Falls der absolute Wert von f(x) kleiner als 10^NACHKOMMASTELLE, 
    % dann terminiere die While-Schlaufe
    if(abs(f(x_n) - f(x0)) < tol)
        % Iteration wird abgebrochen 
        break;
    end
    
    % Anzeige
    disp(['   n                   xn']);
    disp([n x0]);
    
    % Berechnung von fn Funktionswertes mit erstem Wert (x0)
    fn = double(f(x0));
    % Berechnung f_n+1 Funktionswertes mit zweitem Wert (x1)
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


end
