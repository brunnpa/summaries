% Berechnet das Gleichungssystem mit dem Cholesky Verfahren
%
% PARAMETER
% A = Die Matrix zum lösen
%
% RETURN
% R = Die obere rechte Matrix
% L = Die linke untere Matrix
%
% SAMPLE
% [R, L] = cholesky([1 2 3; 2 5 7; 3 7 26])
% A = gallery('lehmer',6); -> [R, L] = cholesky(A)
function [R,L] = cholesky(A)
    
    [i,j] = size(A);
    R = zeros(i);
    
    for (k = 1:i)
        for (u = k:j)
            
            % cover diagonal
            if (k == u)
                summenzeichen = 0;
                for (l = 1:k-1)
                       summenzeichen = summenzeichen + (R(l,k))^2; 
                end
                S = A(k,u) - summenzeichen;
                if (S <= 0)
                    error('not positive definite');
                end
                R(k,u) = sqrt(S);
            end
            
            % cover the other
            if (k ~= u)
                summenzeichen = 0;
                for (l = 1:k-1)
                    summenzeichen = summenzeichen + (R(l,k)*R(l,u));
                end
                R(k,u) = 1/R(k,k) * (A(k,u) - summenzeichen);
            end
        end
    end
    L = R';
end

