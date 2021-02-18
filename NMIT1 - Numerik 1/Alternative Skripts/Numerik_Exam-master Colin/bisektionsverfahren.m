% Berechnet Nullstellen mit dem Bisektionsverfahren
%
% PARAMETERS:
% func = die Funktion um Nullstellen zu finden
% a = startwert interval
% b = endwert interval
% tolerance = erlaubte Toleranz
% 
% RETURN:
% root = Nullstelle
% xint = funktionswerte für jeden Funktionsdurchlauf
% n = anzahl Iterationen um Genauigkeit zu erreichen
%
% SAMPLE: 
% [root,xint,n] = bisektionsverfahren(@(x) x.^3-x+0.3,0,0.5,0.001)
% [root,xint,n] = bisektionsverfahren(@(x) x.^2-2,1,2,0.001)
% [root,xint,n] = bisektionsverfahren(@(x) 88.*x.^3+52.*x.^2+x-2,-1,-0.4,0.001)
function [root,xint,n] = bisektionsverfahren(func, a, b, tolerance)
    format long;
    % maximum iterations, before the function stops
    nMax = 1000000;
    
    %Error handling
    if tolerance < 0
        error('tolerance must be greater than 0\n');
    end
    if( func(a) * func(b) ) >= 0
        error('the interval has no 0-place\n');
    end
    if (a>b)
        error('a must be smaller than b');
    end
    
    % start bisection method
    n = 0;
    xint = 0;
    root = 0;
    median = 0;
    while( abs((a-b)) > tolerance)
        if(n == nMax)
            fprintf('with the tolarance of %d, the maximum amount of Iterations are reached, %d Iterations done, 0-place between %d and %d\n',...
                tolerance,n, a, b);
            return;
        end
        
        median = (a+b)/2;
        xint(n+1)= func(median);
        
        if( func(a) * func(median) ) >= 0
            a = median;
        else
            b = median;
        end
        n = n+1;
    end
    root = median;
end
