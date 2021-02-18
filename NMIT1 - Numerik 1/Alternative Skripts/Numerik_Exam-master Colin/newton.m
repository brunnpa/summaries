% Berechnet die Nullstelle mit dem Newton Verfahren
% 
% PARAMETERS:
% func = die Funktion (e.g. @(x) x.^2 - 2)
% func_abl = die abgeleitete Funktion (e.g. @(x) 2.*x)
% start = startwert
% tol = toleranz
%
% RETURN:
% nullstelle = die Nullstelle
% iter = anzahl iterationen um toleranz zu erreichen
%
% SAMPLE:
% [nullstelle,iter] = newton(@(x) x.^2 - 2,@(x) 2.*x, 2, 0.0001)
function [nullstelle,iter] = newton(func,func_abl,start,tol)
    n = 1;
    xn = start;
    x(n) = start;
    while 1
        x(n+1) = xn - (func(xn) / func_abl(xn));
        n = n+1;
        xn = x(n);
        
        if( (abs(x(n) - x(n-1))) <= tol )
            break;
        end
    end
    nullstelle = x(n);
    iter = n;
end

