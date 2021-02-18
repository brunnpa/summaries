function [x,y] = modeuler(f, a, b, n, y0)

    h = (b - a) / n;

    x = a:h:b;
    
    y = [y0];
    
    for i = 2:n+1
        x2 = x(i);

        y1 = y(i-1);
        y2 = y(i-1) + h*f(x(i-1), y(i-1));
        y3 = y2 + h*f(x2, y2);
        
        k1 = (y2 - y1) / h;
        k2 = (y3 - y2) / h;
        
        y(i) = y(i-1) + h*(k1 + k2) / 2;
    end

end

