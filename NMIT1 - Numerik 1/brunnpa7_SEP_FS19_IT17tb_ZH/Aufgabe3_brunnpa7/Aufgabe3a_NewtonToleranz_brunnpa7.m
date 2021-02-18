% NEWTONVERFAHREN MIT ANGEGEBENER TOLERANZ
% 
% INPUT:
% muss direkt in der Funktion angepasst werden
% f = die Funktion (e.g. @(x) x.^2 - 2)
% fStrich = die abgeleitete Funktion (e.g. @(x) 2.*x)
% start = startwert
% tol = toleranz
%
% OUTPUT:
% nullstelle = die Nullstelle
% iter = Anzahl iterationen um toleranz zu erreichen
%
% BEISPIELAUFRUF:
% [nullstelle,iter] = IV_LGS_NewtonToleranz_brunnpa7
function [nullstelle,iter] = Aufgabe3a_NewtonToleranz_brunnpa7
    format long;
    % Funktion definieren
    % x steht für die Werte p gemäss Aufgabenstellung
    f = @(x) x.^0.3 + x.^0.5 - 0.01 * x;
    
    % Ableitung der Funktion definieren
    fStrich = @(x) 1/(2*x.^(1/2)) + 3/(10*x.^(7/10)) - 1/100;
    
    % Startwert festlegen gemäss aufgabenstellung p0 = 200
    start = 200;
    
    % Toleranz festlegen
    tol = 10^-2;

    % Variablen initialisieren
    n = 1;
    xn = start;
    x(n) = start;
    while 1
        x(n+1) = xn - (f(xn) / fStrich(xn));
        n = n+1;
        xn = x(n);
        
        if( (abs(x(n) - x(n-1))) <= tol )
            break;
        end
    end
    nullstelle = x(n);
    iter = n;
end

