% GAUSS
%
% INPUT:
% A = die Matrix
% b = den Resultatvektor
%
% OUTPUT:
% A_triangle = die gelöste Matrix
% detA = die Determinante
% x = die Lösung von Ax = b
%
% BEISPIELAUFRUF:
% [A_triangle,detA,x] = IV_LGS_Gauss_brunnpa7([1 2 3; 4 5 6; 7 8 10],[14; 3; 9])

function [A_triangle, detA, x] = IV_LGS_Gauss_brunnpa7
    
    A = [64 16 20; 16 68 16; 20 16 64];
    b = [32.4; 26.4; 41.2];
    % Bestimmen der Matrix-Höhe
    n = size(A,1);

    % Überprüfung ob Höhe(A) == Höhe(b) ist
    if (n ~= size(b,1))
        error('the dimension is not matching. The height must be the same');
    end

    % Initialisierung des x-Wertes
    x = zeros(n,1);
    
    for i = 1 : n-1 
        m = A(i+1:n,i)/A(i,i);
        A(i+1:n,:) = A(i+1:n,:) - m*A(i,:);
        b(i+1:n,:) = b(i+1:n,:) - m*b(i,:); 
    end
    A_triangle = A;

    % Rückwärtseinsetzen
    x(n,:) = b(n,:)/A(n,n);
    for i = n-1 : -1 :1
        x(i,:) = (b(i,:) - A(i,i+1:n)*x(i+1:n,:)) / A(i,i);
    end

    % Determinante A bestimmen
    detA = 1;
    for l=1:n
        detA = detA * A_triangle(l,l);
    end  
end

