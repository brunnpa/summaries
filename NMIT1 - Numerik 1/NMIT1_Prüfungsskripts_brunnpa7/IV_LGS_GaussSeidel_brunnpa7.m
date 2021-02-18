% GAUSS SEIDEL VERFAHREN
%
% INPUT
% A = die Matrix (e.g. [4 -1 1; -2 5 1; 1 -2 5])
% b = der Vektor (e.g. [5; 11; 12])
% x = der Startvektor (e.g. [0;0;0])
% tolerance = erlaubte Toleranz im Resultat (e.g. 10^(-4))
% 
% OUTPUT
% xGau = der Resultatvektor
% iterations = Anzahl gebrauchte Iterationen
% estimatedIteration = Anzahl geschätzte Iterationen
%
% BEISPIELAUFRUF
% [xGau, iterations, estimatedIteration] = IV_LGS_GaussSeidel_brunnpa7([4 -1 1; -2 5 1; 1 -2 5], [5; 11; 12], [0;0;0], 10^(-4))
function [xGau, iterations, estimatedIteration] = IV_LGS_GaussSeidel_brunnpa7(A, b, x, tolerance)
    % Diagonal Matrix herausfinden
    % diag(A) liefert eine 1-dimensionale Matrix
    % diag(diag(A)) liefert die diagonale Matrix entsprechend der korrekten
    % Dimension
    D = diag(diag(A)); 
    
    % Linke und Rechte Matrix (ohne Diagonale)
    % tril extrahiert den "lower" triangular Part
    L = tril(A)-D;
    % triu extrahiert den "upper" triangular Part
    R = triu(A)-D;
    % Initialisierung von B
    B = 0;
    
    B = (-1) * inv(D+L) * R;
    xGau = (-1) * inv(D+L) * R * x + inv(D+L) * b;
    
    iterations = 0;
    xstart = x;
    xlast = xstart;
    
    while( ~IV_LGS_aPrioriMatrixGaussJacobi_brunnpa7(xGau, xlast, B, tolerance))
        iterations = iterations + 1;
        xlast = xGau;
        xGau = (-1) * inv(D+L) * R * xlast + inv(D+L) * b;
    end
    estimatedIteration = IV_LGS_aPrioriMatrixGaussJacobi_brunnpa7(xstart, xlast, B, tolerance);
end