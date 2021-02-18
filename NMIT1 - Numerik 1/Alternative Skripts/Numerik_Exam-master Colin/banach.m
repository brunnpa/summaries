% SAMPLE:
% [a_post, iter, alpha] = banach(@(x) x.^3+0.3,@(x) 3.*x.^2, 0, 5, 0.5)
function [a_post, iter, alpha] = banach(func,func_abl, startInt, endInt, fehler)
    % initialize
    a_post = 0;
    iter = 0;
    alpha = 0;


    % Test ob auf gleichen Intervall
    a = func(startInt);
    b = func(endInt);
    if ( a < startInt || b > endInt )
        error('nicht im intervall');
    end
    
    % alpha berechnen
    alpha = max(func_abl(startInt:0.1:endInt));
    
    if ( ( abs(a-b) / abs(startInt-endInt) ) > alpha )
        error('nicht möglich da alpha zu klein');
    end
    
    % a priori
    iter = ( log(fehler/ abs(a/1-alpha) ) ) / log(alpha);
    
    n = 1;
    u = 0;
    x(n) = a;
    while n < iter
        x(n+1) = func(x(n));
        n = n+1;
        
        if( abs(x(n) - x(n-1)) < fehler )
            u = n;
        end
    end
    
    a_post = u;
end

