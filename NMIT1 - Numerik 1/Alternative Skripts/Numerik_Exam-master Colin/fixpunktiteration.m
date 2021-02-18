% Berechnet eine Nullstelle mithilfe der Fixpunktiteration
%
% PARAMETER:
% func = die Funktion (bereits umgeformt nach x) (e.g. @(x) x.^3+0.3)
% tolerance = Toleranz zur wirklichen Nullstelle
% start = Startwert
%
% RETURN:
% result = die Nullstelle
% n = Anzahl Iterationen
%
% SAMPLE:
% fixpunktiteration(@(x) x.^3+0.3, 0.0001, -1)
% fixpunktiteration(@(x) x.^3+0.3, 0.0001, -2)
function [result, n] = fixpunktiteration(func, tolerance, start)
    nmax = 10000;
    tmpResult = func(start);
    lastResult = start;
    n = 0;
    while ((n < nmax) && (abs(lastResult - tmpResult) > tolerance) )
        lastResult = tmpResult;
        tmpResult = func(lastResult);
        n = n + 1;
    end
    result = tmpResult;
end

