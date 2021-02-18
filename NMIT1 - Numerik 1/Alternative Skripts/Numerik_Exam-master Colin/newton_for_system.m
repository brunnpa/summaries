% Berechnet die Nullstellen einer Matrix mit x-Funktionen
%
% PARAMETER
% startVektor = der Startvektor
% tolerance = die Toleranz
%
% RETURN
% nextX = die Nullstelle
%
% SAMPLE
% [nextX] = newton_for_system([4,2], 10^(-4))
function [nextX] = newton_for_system(startVektor, tolerance)
    nmax = 10000;
    % Define some functions
    % -> 2x2 Matrix, für grössere Matrizen, mehr Funktionen definieren +
    % mehr Buchstaben
    syms f1(x,y)
    syms f2(x,y)
    
    % Define the master function
    syms f(x,y)
    
    % hardcode the functions
    f1 = 2*x + 4*y;
    f2 = 4*x + 8*y^3;
    
    % Merge all functions
    f(x,y) = [f1;f2];
    
    % calculate jacobi matrix
    Df = jacobian(f, [x,y]);
    
    % start loop
    lastX = startVektor;
    nextX = zeros(1,2);
    iterations = 0;
    X = Df;
    while ( (abs(nextX-lastX) >= tolerance) & (iterations < nmax) )
        if(iterations ~= 0)
            lastX = nextX;
        end
        X = Df(lastX(1), lastX(2));
        f_value = (f(lastX(1), lastX(2))) * (-1);

        delta = X \ f_value;

        nextX(1) = lastX(1) + delta(1);
        nextX(2) = lastX(2) + delta(2);
        iterations = iterations + 1;
    end
end

