% Löst eine Matrix mit dem Gauss Verfahren auf
%
% PARAMETER:
% A = die Matrix
% b = den Resultatvektor
%
% RETURN:
% A_triangle = die gelöste Matrix
% detA = die Determinante
% x = die Lösung von Ax = b
%
% SAMPLE:
% [A_triangle,detA,x] = gauss ([1 2 3; 4 5 6; 7 8 10],[14; 3; 9])
function [A_triangle,detA,x] = gauss (A,b)
    n = size(A,1); % get matrix height

    % error handling
    if (n ~= size(b,1))
        error('the dimension is not matching. The height must be the same');
    end

    x = zeros(n,1);
    for i=1:n-1 
        m = A(i+1:n,i)/A(i,i);
        A(i+1:n,:) = A(i+1:n,:) - m*A(i,:);
        b(i+1:n,:) = b(i+1:n,:) - m*b(i,:); 
    end
    A_triangle = A;

    % back substitution
    x(n,:) = b(n,:)/A(n,n);
    for i=n-1:-1:1
        x(i,:) = (b(i,:) - A(i,i+1:n)*x(i+1:n,:)) / A(i,i);
    end

    % detA
    detA = 1;
    for l=1:n
        detA = detA * A_triangle(l,l);
    end  
end

