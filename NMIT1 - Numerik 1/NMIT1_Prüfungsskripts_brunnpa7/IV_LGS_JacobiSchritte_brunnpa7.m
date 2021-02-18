% JACOBI-Verfahren
%
% INPUT
% A = die Matrix (e.g. [4 -1 1; -2 5 1; 1 -2 5])
% b = der Vektor (e.g. [5; 11; 12])
% x = der Startvektor (e.g. [0;0;0])
% nMax = Anzahl Iterationen
% tolerance = erlaubte Toleranz im Resultat (e.g. 10^(-4))
% 
% OUTPUT
% xJac = der Resultatvektor
% iterations = Anzahl gebrauchte Iterationen
% estimatedIteration = Anzahl geschätzte Iterationen
%
% BEISPIELAUFRUF
% [xJac, iterations, estimatedIteration] = IV_LGS_JacobiSchritte_brunnpa7(A, b, x, nMax)
% [xJac, iterations, estimatedIteration] = IV_LGS_JacobiSchritte_brunnpa7([4 -1 1; -2 5 1; 1 -2 5], [5; 11; 12], [0;0;0], 5)

function [xJac, iterations, estimatedIteration] = IV_LGS_JacobiSchritte_brunnpa7(A, b, x, nMax)
    format long;
    tolerance = 10.^-4;
    % Diagonal Matrix herausfinden
    % diag(diag(X)) ist die diagonal-Matrix
    D = diag(diag(A)); 
    
    % Linke und Rechte Matrix (ohne Diagonale)
    % tril(A) lower triangular
    L = tril(A)-D;
    % triu(A) upper triangular
    R = triu(A)-D;
    % B initialisieren
    B = 0;
    
    B = (-1) * inv(D) * (L+R);
    xJac = (-1)*D\(L+R)*x+D\b;
    
    iterations = 0;
    xstart = x;
    xlast = xstart;
    
    while(iterations < nMax)
        iterations = iterations + 1;
        xlast = xJac;
        xJac = (-1)*D\(L+R)*xlast+D\b;
    end
    estimatedIteration = IV_LGS_aPrioriMatrixGaussJacobi_brunnpa7(xstart, xlast, B, tolerance);
end