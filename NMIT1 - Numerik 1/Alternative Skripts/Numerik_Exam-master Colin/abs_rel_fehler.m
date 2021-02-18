% Berechnet den absoluten und relativen Fehler
%
% PARAMETER
% x = korrektes Resultat
% xSchl = nährung
%
% RETURN
% absol = absoluter Fehler
% rel = relativer Fehler
% 
% SAMPLE
% [absol,rel] = abs_rel_fehler(5,5.2)
function [absol,rel] = abs_rel_fehler(x,xSchl)
    absol = abs(x-xSchl);
    rel = abs(absol/abs(x));
end

