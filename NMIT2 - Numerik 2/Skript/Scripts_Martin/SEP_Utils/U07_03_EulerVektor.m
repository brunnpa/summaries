f = @(x, y) [y(2),2*x-cos(y(1))*x^2];
a = 1;
b = 10;
n = 18;
y0 = [2; -1];

[x,y] = eulerKlassischV(f, a, b, n, y0);
plot(x,y(:,1))


% Die Lösung befindet sich in der ersten Komponente des Vektors y
plot(x, y(:,1));


% --------------------------------------------
% Klassisches Euler-Verfahren für Vektoren
% f = Differenzialgleichungen
% a = Startwert
% b = Endwert
% n = Anzahl Schritte
% y0 = Startwerte
% Rückgabewerte:
% (xi, yi) = n - berechnete Punkte der Funktion
% Aufruf:
% [x,y] = eulerKlassischV(@(x, y) [y(2),2*x-cos(y(1))*x^2], -1.5, 1.5, 18, [2; -1])
% --------------------------------------------
function [x, y] = eulerKlassischV(f, a, b, n, y0)
    h = (b-a)/n;

    x = zeros(n+1, 1);
    y = zeros(n+1, 2);

    y(1,:) = y0;
    x(1) = a;

    for i=1:n
       x(i+1) = x(i) + h;
       y(i+1,:) = y(i,:) + h .*  f(x(i), y(i,:));
    end
end

