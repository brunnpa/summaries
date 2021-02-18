% Berechnet eine Nullstelle mithilfe der Fixpunktiteration
%
% INPUT:
% func = die Funktion (bereits umgeformt nach x) (e.g. @(x) x.^3+0.3)
% tolerance = Toleranz zur wirklichen Nullstelle -> Abbruchkriterium
% start = Startwert
%
% OUTPUT:
% result = die Nullstelle
% n = Anzahl benötigten Iterationen
%
% BEISPIELAUFRUF:
% III_Nullstellen_Fixpunktiteration_brunnpa7(@(x) x.^3+0.3, 0.0001, -1)
% III_Nullstellen_Fixpunktiteration_brunnpa7(@(x) x.^3+0.3, 0.0001, -2)

function [result, n] = Aufgabe3c_Fixpunktiteration_brunnpa7(func, tolerance, start)
    % Maximale Anzahl Iteration
    nmax = 10000;
    tmpResult = func(start);
    lastResult = start;
    n = 0;
    
    % Je nach Bediengung kann nur nach Anzahl Iterationen oder nur nach
    % Toleranz als Kriterium abgebrochen werden
    while ((n < nmax) && (abs(lastResult - tmpResult) > tolerance) )
        lastResult = tmpResult;
        tmpResult = func(lastResult);
        n = n + 1;
    end
    result = tmpResult;
end

