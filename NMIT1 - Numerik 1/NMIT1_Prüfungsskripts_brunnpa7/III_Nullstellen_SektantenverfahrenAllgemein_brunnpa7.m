% Berechnet die Nullstellen mit dem Sekantenverfahren
%
% PARAMETERS:
% func = die Funktion wo die Nullstellen berechnet werden
% x0 = erster Startwert
% x1 = zweiter Startwert
% tol = erlaubte Toleranz
%
% RETURN:
% result = Nullstelle
% n = anzahl Iterationen
% 
% SAMPLE:
% [result,iter] = III_Nullstellen_SektantenverfahrenAllgemein_brunnpa7(@(x) exp(x^2) + x^(-3) -10, -1.0, -1.2,10^(-5))
%
function [result,iter] = III_Nullstellen_SektantenverfahrenAllgemein_brunnpa7(func,x0,x1,tol) 
    % Initialize values
    x(1) = x0;
    x(2) = x1;
    n = 2;
    iter = 0;
    result = 0;
    % if the value of the two last 0-places is still bigger than the
    % tolerance --> loop (calculate next one)
    while ( (abs(x(n)-x(n-1))) >= tol )
        % division
        div = ( (x(n)-x(n-1)) / ( func(x(n)) -func(x(n-1)) ) );
        % next 0-place
        x(n+1) = x(n) - (div  * func(x(n)) ); 
        % increase counter
        n = n + 1;
        iter = iter+1;
    end
    % assign last 0-place to y
    result = x(n);
end

