% Führt für ein Gleichungsystem Ax = b den Gauss-Algorithmus durch und
% rechnet die Determinante für A
%
% A = [200 150 100 ; 50 30 20 ; 20 10 0]
% b = [2150;470;150]
% [A_triangle, detA, x] = gauss(A, b)
%
% A          = Gleichungssystem als Matrix
% b          = Ziel-Vektor des Gleichungssystems
% A_triangle = Dreiecksmatrix nach gauss
% detA       = Determinante von A
% x          = Lösung des Gleichungssystems
%
function [A_triangle, detA, x] = gauss(A,b)
   format rat
   if (size(A,1) ~= size(b,1))
       error('Dimensions of Matrix and Vector do not match:\nMatrix: %d x %d, Vector: %d x %d', size(A,1), size(A,2), size(b,1), size(b,2)); 
   end
   
   M = [A b];
   height = size(M,1);
   width = size(A);
   
    for row = 1 : height - 1
        if M(row, row) == 0
            hasSwaped = false;
            for j = row + 1: height
                if M(j, row) ~= 0
                    temp = M(row,:);
                    M(row,:) = M(j,:);
                    M(j,:) = temp;
                    hasSwaped = true;
                    break;
                end
            end
            if(hasSwaped == false)
                error('Matrix is sigular');
            end
        end
        for i = row + 1: height
            fac = M(i, row) / M(row, row);
           % M(i, row + 1: end) = M(i, row + 1: end) - (fac * M(row, row + 1: end));
         M(i, 1: end) = M(i, 1: end) - (fac * M(row, 1: end));
        end
    end
  
    if M(height, width) == 0
        error('Matrix is sigular');
    end
    
    % build triangle matrix from M
    A_triangle = M(1:height,1:width);
    bGauss = M(:, width + 1);
    
    % calc determinate
    detA = 1;
    for l=1:height
       detA = detA * A_triangle(l,l);
    end
    
    % set back
    x = zeros(1);
    for i=height:-1:1
        sum = 0;
        for j=i+1:height
            sum = sum + (A_triangle(i,j) * x(j));
        end
        
        x(i, 1) = ((bGauss(i) - sum) / A_triangle(i,i));
    end

end



% Dominique Reiser