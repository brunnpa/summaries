% BISEKTIONSVERFAHREN 
% 
% INPUT:
% @(x) sin(x).*cos(x) die anonyme Funktion ist
% -1 und 1 ist das Intervall, in dem die Nullstelle vermutet wird
% 0.1 die Toleranz ist
% 
% OUTPUT:
% root ist die Nullstelle
% xit ist ein Vektor der Iterationswerte
% n ist die Anzahl der benötigten Iterationen
% 
% Beispielaufruf:
% [root, xint, n] = III_Nullstellen_Bisektionsverfahren_brunnpa7 
% ALTERNATIVE AURFUF MIT PARAMETER:
% [root, xint, n] = III_Nullstellen_Bisektionsverfahren_brunnpa7 (func, a, b, tol)

function [root, xint, n] = III_Nullstellen_Bisektionsverfahren_brunnpa7
    % Format definieren
    format long;
    % Initialisierung
    func = @(x) x.^2 - 2;
    a = 1;
    b = 1.5;
    tol = 10.^-4;
    % Matlab Array fängt bei 1 an 
    n = 1; 
    
    % Bedingung für die Terminierung festlegen
    % Maximale Anzahl Iterationen
    nMax = 10000000;
    
    % Vorbedingung prüfen -> Vorzeichenwechsel muss stattfinden
    % f(a) * f(b) < 0 
    if(func(a) * func(b) >= 0)
       error('Thats not a valid input -> it has to be: f(a) * f(b) < 0');
    end
    
    % Bedingung prüfen
    if tol <= 0
       error('tolerence has to be bigger than 0');
    end
    
    %"Bisektionsverfahren"
    while(1)
        % Überprüfe ob n grösser/gleich nMax ist, 
        % Falls ja -> TERMINATE
        % Kann Alternativ weggelassen werden
        if n >= nMax
          error('too many steps needed - terminated!'); 
        end
       
        % Überprüfe ob die Toleranzbedingung bereits erreicht wurde
        % Falls -> Bisketionsverfahren kann gestoppt werden und Resultat
        % wird ausgegeben
        if(abs(b-a) <= tol) 
            root = a_b;
            return
        end
       
        % Berechnung der neuen Intervallgrenze
        a_b = (a + b) / 2;
        
        % Speichere das neue Resultat unter der Anwendung der neuen
        % Intervallgrenze in der vorgegebenen Funktion
        % -> Speicherung im xint(n) Array
        xint(n) = func(a_b);
        
        % Überprüfe wo die Intervallgrenze gesetzt wird
        if(func(a)*func(a_b) <= 0)
            % b wird neu Intervallgrenze a_b
            b = a_b; %[(a+b)/2, b]
        else
            % a wird neu Intervallgrenze a_b
            a = a_b; %[a, (a+b)/2]
        end
        n = n + 1;
    end
end