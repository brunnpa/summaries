function [x,y] = euler()
    f = @(x,y) x.^2 + y;
    a = 0;
    b = 3;
    y0 = -0.5;
    n =2;

    h = (b - a) / n;
    
    x = a:h:b;
    
    y = [y0];
    
    for i = 2:n+1
        y(i) = y(i-1) + h*f(x(i-1), y(i-1));
    end
    
end

