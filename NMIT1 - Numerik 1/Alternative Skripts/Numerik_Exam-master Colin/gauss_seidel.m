% Berechnet den Resultatvektor mit dem Gauss-Seidel-Verfahren
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
% [xGau, iterations, estimatedIteration] = gauss_seidel([4 -1 1; -2 5 1; 1 -2 5], [5; 11; 12], [0;0;0], 10^(-4))
function [xGau, iterations, estimatedIteration] = gauss_seidel(A, b, x, tolerance)
    % Diagonal Matrix herausfinden
    D = diag(diag(A)); % diag(diag(X)) is a diagonal matrix
    
    % Linke und Rechte Matrix (ohne Diagonale)
    L = tril(A)-D;
    R = triu(A)-D;
    B = 0;
    
    B = (-1) * inv(D+L) * R;
    xGau = (-1) * inv(D+L) * R * x + inv(D+L) * b;
    
    iterations = 0;
    xstart = x;
    xlast = xstart;
    
    while( ~aPosterioriMatrix(xGau, xlast, B, tolerance))
        iterations = iterations + 1;
        xlast = xGau;
        xGau = (-1) * inv(D+L) * R * xlast + inv(D+L) * b;
    end
    estimatedIteration = aPrioriMatrix(xstart, xlast, B, tolerance);
end