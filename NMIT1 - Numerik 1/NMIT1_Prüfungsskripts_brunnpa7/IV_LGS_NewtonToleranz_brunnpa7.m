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
function [nullstelle,iter] = IV_LGS_NewtonToleranz_brunnpa7
    format long;
    % Funktion definieren
    f = @(x) x.^2 - 2;
    
    % Ableitung der Funktion definieren
    fStrich = @(x) 2.*x;
    
    % Startwert festlegen
    start = 2;
    
    % Toleranz festlegen
    tol = 0.0001;

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

