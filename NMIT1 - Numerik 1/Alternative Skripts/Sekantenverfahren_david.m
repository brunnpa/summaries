% Sekantenverfahren
function [y] = Sekantenverfahren_david() 

format long

% Funktion definieren
f = @(x) x^2 - 1;

% Startwerte definieren
x0 = -0.5;
x1 = 3;

% tol definieren
tol = 0.001;

y(1) = x0;
y(2) = x1;

n = 2;

% While(1), da die Abbruchbedingung auf tol beruht
while (1)
    % Abbruchbedingung für Sekantenverfahren
    if (abs(y(n)- y(n-1) < tol))
        break;
    end
    
    y(n+1) = y(n) - ((y(n) -y(n-1))/(f(y(n)) - f(y(n-1)))* f(y(n)));
    
    n = n + 1;
end

% Resultat auf Konsole ausgeben
plot(y)

end