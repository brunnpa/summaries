% A-POSTERIORI NACH FIXPUNKTITERATION
%
% INPUT:
% abweichung = angegebene Abweichung
%
% OUTPUT:
% r = boolean 1 wenn toleranz erreicht
%
% BEISPIELAUFRUF
% [r] = III_Nullstellen_aPosterioriMatrixFixpunktiteration_brunnpa7(10^-4, 0.3, 0, 0.75)
%
function [r] = III_Nullstellen_aPosterioriMatrixFixpunktiteration_brunnpa7(abweichung, xn, x_n1, alpha)
    fehlerabschaetzung = (alpha/(1-alpha) * abs(x_n1-xn));
    r = fehlerabschaetzung <= abweichung;
end