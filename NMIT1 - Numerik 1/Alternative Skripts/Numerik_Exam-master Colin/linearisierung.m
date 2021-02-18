% Berechnet die Linearisierung von Funktionen mit mehreren Variablen
%
% PARAMETER
% startVektor = der Startvektor
%
% RETURN
% resultat = die Linearisierungsfunktion
%
% SAMPLE
% [resultat] = linearisierung([1,1])
function [resultat] = linearisierung(startVektor)

    syms f1(x,y)
    syms f2(x,y)
    % Define the master function
    syms f(x,y)
        
    % hardcode the functions
    f1 = x^2 + y - 11;
    f2 = x + y^2 - 7;
    
    % Merge all functions
    f(x,y) = [f1;f2];
    
    % calculate jacobi matrix
    Df = jacobian(f, [x,y]);
    
    val = f(startVektor(1), startVektor(2));
    Df = Df(startVektor(1), startVektor(2));
    
    u1 = x-startVektor(1);
    u2 = y-startVektor(2);
    xVektor = [u1;u2];
    
    resultat = val + (Df * xVektor);
end

