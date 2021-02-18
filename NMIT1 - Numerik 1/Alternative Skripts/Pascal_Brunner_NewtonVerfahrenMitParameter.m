% NEWTON-VERFAHREN mit PARAMETER
% 
% INPUT:
% f = die Funktion (e.g. @(x) x.^2 - 2)
% fStrich = die abgeleitete Funktion (e.g. @(x) 2.*x)
% start = startwert
% tol = toleranz
%
% OUTPUT:
% nullstelle = die Nullstelle
% iter = anzahl iterationen um toleranz zu erreichen
%
% BEISPIELAUFRUF:
% [nullstelle,iter] = Pascal_Brunner_NewtonVerfahrenMitParameter(@(x) x.^2 - 2,@(x) 2.*x, 2, 0.0001)
function [nullstelle,iter] = Pascal_Brunner_NewtonVerfahrenMitParameter(f,fStrich,start,tol)
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

