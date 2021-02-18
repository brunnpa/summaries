function [dx] = Berg_Michael_It17tb_ZH_S1_Auf3a(x,y)
    len = length(x);
    
    % Vorw?rtsdifferenz (Index beginnt bei 1)
    % D1f = (f(x1 + h) - f(x1))/h
    % h = x2 - x1
    dx(1) = (y(2) - y(1))/ (x(2) - x(1));
    
    for i = 2:(len-1)
        % Hier ist das Problem, dass y(x(i) + x(i+1) - x(i-1)),
        % bzw. y(x(i) - x(i+1) + x(i-1)), nicht zwingend definiert ist
        % (abh?ngig von den input arrays der Funktion)
        dx(i) = (y(x(i) + x(i+1) - x(i-1)) - y(x(i) - x(i+1) + x(i-1))) / (2*(x(i+1) - x(i-1))); % Zentrale Differenz
    end

    % R?ckw?rtsdifferenz
    % D1f = (f(x_n) - f(x_n-1))/h
    % h = x_n - (x_n-1)
    dx(len) = (y(len) - y(len-1)) / (x(len) - x(len-1)); 
end

