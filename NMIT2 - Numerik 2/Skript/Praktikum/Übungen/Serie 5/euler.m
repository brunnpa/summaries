function [x,y] = euler(f, a, b, n, y0)
 
    h = (b - a) / n;
    
    x = a:h:b;
    
    y = [y0];
    
    for i = 2:n+1
        y(i) = y(i-1) + h*f(x(i-1), y(i-1));
    end
    
end

