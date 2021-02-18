function dx = D4D5D6Diskret(x,y)
% Es liegen diesmal diskrete Wertepaare vor und keine
% allgemeine Schrittweite.

% Mithilfe der Wertpaare (xi, yi) wird die zweite 
% Ableitung in eben jenem Punkt berechnet. Dafür werden die Methoden
% Vorwärts-, Zentral- und Rückwärtsdifferenz verwendet.

% Die eindimensionalen Arrays
% dx, x und y haben also alle die gleiche Anzahl Elemente n. 
% Benutzen Sie für das erste Wertepaar die Vorwärtsdifferenz,
% für das letzte Wertepaar die Rückwärtsdierenz, und dazwischen die zentrale Dierenz. 
% Benutzen Sie für den Abstand h jeweils die diskrete Variante

if (length(x) ~= length(y))
    error 'Die beiden Vektoren x und y müssen die gleiche Länge besitzen';
end

% Definitionen der Differenzen als diskrete Werte
D1f = @(y, yNext, x, xNext) (yNext - y) / (xNext-x);
D2f = @(yPrev, yNext, xPrev, xNext) (yNext - yPrev) / (xNext - xPrev);
D3f = @(yPrev, y, xPrev, x) (y - yPrev) / (x - xPrev);

D4f = @(y, yNext, yNextNext, x, xNext) (( yNextNext - 2*yNext + y ) / (xNext-x)^2);
D5f = @(y, yNext, yNextNext, x, xNext) (( yNext - 2*y + yPrev ) / (xNext-x)^2);
D6f = @(y, yNext, yNextNext, x, xNext) (( y - 2*yPrev + yPrevPrev)

% Definiert die Anzahl der Diff-Schritte
iMax    = length(x);
% Definiert das eindimensionale array
dx      = zeros(length(x), 1);

for i = 1:iMax
    if (i == 1)         % Erste Zeile: D1f
        dx(i) = D1f(y(i), y(i+1), x(i), x(i+1));
    elseif (i == iMax)  % Letzter Eintrag: D3f
        dx(i) = D3f(y(i-1), y(i), x(i-1), x(i));
    else                % Dazwischen: D2f
        dx(i) = D2f(y(i-1), y(i+1), x(i-1), x(i+1));
    end
end
