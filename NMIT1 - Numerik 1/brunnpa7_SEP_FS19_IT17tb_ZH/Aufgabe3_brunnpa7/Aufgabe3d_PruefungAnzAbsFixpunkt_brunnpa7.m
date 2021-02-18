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
% anziehend = Aufgabe3d_PruefungAnzAbsFixpunkt_brunnpa7
% 

function [anziehend] = Aufgabe3d_PruefungAnzAbsFixpunkt_brunnpa7
    xValue = 200;
        
    syms x
    y = (x^-0.3 + x^-0.5) / 0.01;
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
