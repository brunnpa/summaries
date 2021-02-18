function [dx] = erste_Ableitung_mittels_d1_d2_d3(x,y)
    % Unter Anwendung von d1, d2, d3, kann man eine Ableitung annähern.
    % es werden alle drei Variante benötigt, da sonst einige Stellen
    % (Anfang-/Endstelle) nicht definiert sind.
    len = length(x);
    
    % Vorwärtsdifferenz (Index beginnt bei 1)
    
    % D1f = (f(x1 + h) - f(x1))/h
    % h = x2 - x1
    dx(1) = (y(2) - y(1))/ (x(2) - x(1));
    
    % Zentrale Differenz
    % Beginnend bei 2, da die erste Stelle mittels Vorwärtsdifferenz gelöst
    % wurde
    % bis len-1, da die letzte Stelle des Arrays mittels Rückwärtsdifferenz
    % gelöst wird
    for i = 2:(len-1)
        % Hier ist das Problem, dass y(x(i) + x(i+1) - x(i-1)),
        % bzw. y(x(i) - x(i+1) + x(i-1)), nicht zwingend definiert ist
        % (abhängig von den input arrays der Funktion)
        dx(i) = (y(x(i) + x(i+1) - x(i-1)) - y(x(i) - x(i+1) + x(i-1))) / (2*(x(i+1) - x(i-1))); 
    end

    % Rückwärtsdifferenz
    
    % D1f = (f(x_n) - f(x_n-1))/h
    % h = x_n - (x_n-1)
    dx(len) = (y(len) - y(len-1)) / (x(len) - x(len-1)); 
end

