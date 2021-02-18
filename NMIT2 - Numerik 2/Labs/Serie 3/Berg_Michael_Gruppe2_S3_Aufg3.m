function [T, T_0] = Berg_Michael_Gruppe2_S3_Aufg3(f,a,b,m)
    format short
    
    % first series of values for romberg extrapolation
    % -> D_00 - D_m0
    for i = 0:m-1
        % length of aequidistant pieces
        h = (b - a)/2^i;
        % number of aequidistant pieces
        n = 2^i;
        
        % calculating summated trapez formula for n pieces of length h
        val = h*(f(a) + f(b))/2;
        for j = 1:(n-1)
            val = val + h*f(a + j*h);
        end
        
        d_n(i+1) = val;
    end
    
    % save first series of values
    T_0 = d_n;
    % print first series
    d_n
    
    % romberg extrapolation function
    extrapolation = @(k,d1,d2) ((4^k)*d2 - d1)/((4^k)-1);
    
    % the first series of values has been calculated
    % do the m-1 extrapolations
    for i = 1:m-1
        d_n_after = [];
        for j = 1:m-i
           d_n_after(j) = extrapolation(i,d_n(j),d_n(j+1));
        end
        d_n = d_n_after;
        
        % print current value
        d_n
    end
    
    T = d_n;
end

