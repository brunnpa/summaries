% BANACHSCHER FIXPUNKTITERATION
%
%
% INPUT:
% func = Funktion für die Fixpunktiteration
% startInt = startIntervall
% endInt = endIntervall
% fehler = maximaler Fehler
%
% OUTPUT:
% a_post = 
% iter = Anzahl Iteration
% alpha = Wert von alpha
%
% BEISPIELAUFRUF:
% [a_post, iter, alpha] = III_Nullstellen_Banach_brunnpa7

function [a_post, iter, alpha] = III_Nullstellen_Banach_brunnpa7
        
    format long
    
    % initialize
    a_post = 0;
    iter = 0;
    alpha =  0.6;
    startInt = 0;
    endInt = 1;
    fehler = 10.^-3;
    
    % FIXPUNKTFORM VERWENDEN!!! func dann als anonyme Funktion definieren
    func = @(x) (1/5)*(x.^3+3);
    
    % ABLEITUNG DER FIXPUNKTFORM VERWENDEN!!!
    func_abl = @(x) (3*x.^2)/5;
         
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