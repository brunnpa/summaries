% VEREINFACHTES NEWTONVERFAHREN

function Pascal_Brunner_NewtonVereinfachtesVerfahren
% Format definieren
format long
% Variablen aus Funktion
syms x                  
% Funktion definieren
f(x) = x^2 -2;
% Maximale Anzahl Iterationen
n_max =30; 
% Auf wieviele Kommastrellen genau
nks = 4; 
% Startpunkt x0
x0 = 2;                 

% Ableitung berechnen
fStrich(x) = diff(f,x);
% f'(x0) berechnen
f_n = fStrich(x0);
% xn mit Wert von x0 initialisieren
xn = x0;
% n initialisieren
n = 0;
while (n <= n_max)
    % Funktionswert für fn berechnen
    fn = double(f(xn));
    % x Wert berechnen
    x1 = double(xn-(fn/f_n));
    % Anzeige des Resultats
    disp(['   n                   xn']);
    disp([n xn]);
    % n++
    n = n+1;
    % xn nimmt Wert von x1 an
    xn = x1;
end

end