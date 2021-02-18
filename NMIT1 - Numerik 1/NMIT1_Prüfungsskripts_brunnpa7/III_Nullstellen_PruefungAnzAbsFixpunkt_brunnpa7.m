% PRUEFUNG FIXPUNKT (abstossend oder anziehend)
% 
% INPUT:
% X Wert von Fixpunkt
% 
% OUTPUT:
% 1 wenn Fixpunkt anziehend
% 0 wenn Fixpunkt abstossend
%
% BEISPIELAUFRUF:
% anziehend = III_Nullstellen_PruefungAnzAbsFixpunkt_brunnpa7(0.3389)
% 

function [anziehend] = III_Nullstellen_PruefungAnzAbsFixpunkt_brunnpa7(xValue)
        
    syms x
    y = x^3 + 0.3;
    ydiff = diff(y);
    
    result = subs(ydiff, xValue);
    
    if(result < 1)
        anziehend = 1;
    end
    
    if(result >= 1)
        anziehend = 0;
    end
    
    if(result == 0)
       error('Result of ydiff is exactly zero');
    end
end
