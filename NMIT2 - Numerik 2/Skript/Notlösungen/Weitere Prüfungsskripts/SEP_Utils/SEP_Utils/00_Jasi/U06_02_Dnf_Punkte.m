% Mithilfe der Wertpaare (xi, yi) wird die erste 
% Ableitung in eben jenem Punkt berechnet. Dafür werden die Methoden
% Vorwärts-, Zentral- und Rückwärtsdifferenz verwendet.

% x = 0:10; %X-Werte
% yFunc = @(x) cos(x); % Funktion für y
% y = yFunc(0:10); %Y-Werte, bereits ausgewertet aus einer funktion

t = [0:10:120]';
h = [2, 286, 1268, 3009, 5375, 8220, 11505, 15407, 20127, 25593, 31672, 38257, 44931]';

if (length(x) ~= length(y))
    error 'Die beiden Vektoren x und y müssen die gleiche Länge besitzen';
end

D1f = @(y, yNext, x, xNext) (yNext - y) / (xNext-x);
D2f = @(yPrev, yNext, xPrev, xNext) (yNext - yPrev) / (xNext - xPrev);
D3f = @(yPrev, y, xPrev, x) (yPrev - y) / (xPrev - x);

iMax = length(x);
dx = zeros(length(x), 1);

for i = 1:iMax 
    if (i == 1) % Erste Zeile: Vorwärtsdifferenz
        dx(i) = D1f(y(i), y(i+1), x(i), x(i+1));
    elseif (i == iMax) % Letzte Zeile: Rückwärtsdifferenz
        dx(i) = D3f(y(i-1), y(i), x(i-1), x(i));
    else % Alles in der Mitte: Zentraldifferenz
        dx(i) = D2f(y(i-1), y(i+1), x(i-1), x(i+1));
    end
end

plot(1:iMax,dx);


