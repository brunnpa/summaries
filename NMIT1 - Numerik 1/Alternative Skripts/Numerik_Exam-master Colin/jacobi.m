% Berechnet den Resultatvektor mit dem Jacobi-Verfahren
%
% PARAMETER
% A = die Matrix (e.g. [4 -1 1; -2 5 1; 1 -2 5])
% b = der Vektor (e.g. [5; 11; 12])
% x = der Startvektor (e.g. [0;0;0])
% tolerance = erlaubte Toleranz im Resultat (e.g. 10^(-4))
% 
% RETURN
% xJac = der Resultatvektor
% iterations = Anzahl gebrauchte Iterationen
% estimatedIteration = Anzahl geschätzte Iterationen
%
% SAMPLE
% [xJac, iterations, estimatedIteration] = jacobi([[8 5 2];[5 9 1];[4 2 7]],[19;5;34],[1;-1;3],10^(-4))
% [xJac, iterations, estimatedIteration] = jacobi([4 -1 1; -2 5 1; 1 -2 5], [5; 11; 12], [0;0;0], 10^(-4))
function [xJac, iterations, estimatedIteration] = jacobi(A, b, x, tolerance)
    % Diagonal Matrix herausfinden
    D = diag(diag(A)); % diag(diag(X)) is a diagonal matrix
    
    % Linke und Rechte Matrix (ohne Diagonale)
    L = tril(A)-D;
    R = triu(A)-D;
    B = 0;
    
    B = (-1) * inv(D) * (L+R);
    xJac = (-1)*D\(L+R)*x+D\b;
    
    iterations = 0;
    xstart = x;
    xlast = xstart;
    
    while( ~aPosterioriMatrix(xJac, xlast, B, tolerance))
        iterations = iterations + 1;
        xlast = xJac;
        xJac = (-1)*D\(L+R)*xlast+D\b;
    end
    estimatedIteration = aPrioriMatrix(xstart, xlast, B, tolerance);
end