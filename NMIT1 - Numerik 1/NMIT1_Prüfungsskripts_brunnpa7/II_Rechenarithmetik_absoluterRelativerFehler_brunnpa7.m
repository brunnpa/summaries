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
% [absol,rel] = II_Rechenarithmetik_absoluterRelativerFehler_brunnpa7([-1; 1],[2; -1])
function [absoluterFehler,relativerFehler] = II_Rechenarithmetik_absoluterRelativerFehler_brunnpa7(x,xSchlange)
    absoluterFehler = abs(x-xSchlange);
    relativerFehler = abs(absoluterFehler/abs(x));
end

