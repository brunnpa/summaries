% ABSOLUTER & RELATIVER FEHLER BERECHNEN
%
% INPUT:
% x = korrektes Resultat
% xSchl = nährung
%
% OUTPUT
% absoluterFehler = absoluter Fehler
% relativerFehler = relativer Fehler
% 
% BEISPIELAUFRUF:
% [absoluterFehler,relativerFehler] = Aufgabe1b_absoluterRelativerFehler_brunnpa7
function [absoluterFehler,relativerFehler] = Aufgabe1b_absoluterRelativerFehler_brunnpa7
    x = 0.3320116922736547*(10^-1);
    xSchlange = 0.33201 * (10^-1);
    absoluterFehler = abs(x-xSchlange);
    relativerFehler = abs(absoluterFehler/abs(x));
end

