% CHOLESKY VERFAHREN
%
% INPUT
% A = zulösende A-Matrix
%
% OUTPUT
% R = Die obere rechte Matrix
% L = Die linke untere Matrix
%
% BEISPIELAUFRUF
% [R, L] = IV_LGS_Cholesky_brunnpa7([1 2 3; 2 5 7; 3 7 26])
% A = gallery('lehmer',6); -> [R, L] = IV_LGS_Cholesky_brunnpa7(A)
function [R,L] = IV_LGS_Cholesky_brunnpa7(A)
    
    % Definiere Dimension von i und j
    [i,j] = size(A);
    % initialisiere eine i x i R-Matrix mit 0
    R = zeros(i);
    
    for k = 1 : i
        for u = k : j 
            
            % wenn aktuelles Element, ein Diagonal Element ist addiere es
            if (k == u)
                diagonalSum = 0;
                for m = 1 : k-1
                       diagonalSum = diagonalSum + (R(m,k))^2; 
                end
                S = A(k,u) - diagonalSum;
                if (S <= 0)
                    error('not positive definite');
                end
                R(k,u) = sqrt(S);
            end
            
            % wenn aktuelles Element, kein Diagonal Elemnt ist addiere es
            if (k ~= u)
                otherSum = 0;
                for m = 1 : k-1
                    otherSum = otherSum + (R(m,k)*R(m,u));
                end
                R(k,u) = 1/R(k,k) * (A(k,u) - otherSum);
            end
        end
    end
    L = R';
end

