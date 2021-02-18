% JACOBI-Verfahren
%
% INPUT
% A = die Matrix (e.g. [4 -1 1; -2 5 1; 1 -2 5])
% b = der Vektor (e.g. [5; 11; 12])
% x = der Startvektor (e.g. [0;0;0])
% tolerance = erlaubte Toleranz im Resultat (e.g. 10^(-4))
% max_iterations = maximale Anzahl Iterationen
% 
% OUTPUT
% xJac = der Resultatvektor
% iterations = Anzahl gebrauchte Iterationen
% estimatedIteration = Anzahl geschätzte Iterationen
%
% BEISPIELAUFRUF
% WICHTIG! Wenn man bei tolerenace "inf" eingibt, dann nimmt es nur die
% maximale Anzahl Iterationen
% [xJac, iterations, estimatedIteration] = IV_LGS_Jacobi_brunnpa7([[8 5 2];[5 9 1];[4 2 7]],[19;5;34],[1;-1;3],10^(-4), inf)
% [xJac, iterations, estimatedIteration] = IV_LGS_Jacobi_brunnpa7([4 -1 1; -2 5 1; 1 -2 5], [5; 11; 12], [0;0;0], 10^(-4), 2)
function [xJac, iterations, estimatedIteration, B] = IV_LGS_Jacobi_brunnpa7(A, b, x, tolerance, max_iterations)
    % Diagonal Matrix herausfinden
    % diag(diag(X)) is a diagonal matrix
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
    
    iterations = 1;
    xstart = x;
    xlast = xstart;
    
    while( ~IV_LGS_aPosterioriMatrixGaussJacobi_brunnpa7(xJac, xlast, B, tolerance) && iterations < max_iterations)
        iterations = iterations + 1;
        xlast = xJac;
        xJac = (-1)*D\(L+R)*xlast+D\b;
    end
    estimatedIteration = IV_LGS_aPrioriMatrixGaussJacobi_brunnpa7(xstart, xlast, B, tolerance);
end