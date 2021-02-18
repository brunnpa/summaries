% a-Priori bei Fixpunktiteration
% INPUT:
% abweichung = angebene Abweichung
% x0 = startwert x0
% x1 = startwert x1
% alpha = Lipschitz-Konstante von banachscher Fixpunktsatz
%
%
% OUTPUT:
% n = Anzahl Iterationen
%
% BEISPIELAUFRUF:
% [n] = III_Nullstellen_aPrioriFixpunktiteration
%
% Als Resultat wird dann n <= erhaltenesResultat geschrieben

function [n] = III_Nullstellen_aPrioriFixpunktiteration
    format long;
    abweichung = 10^-8;
    x0 = 1.5;
    x1 = 0.7071067812;
    alpha = 0.980258143468547; % gem. Berechnung im MATLAB Skript
    
    n = log(abweichung * (1 - alpha) / abs(x1-x0)) / log(alpha);

end