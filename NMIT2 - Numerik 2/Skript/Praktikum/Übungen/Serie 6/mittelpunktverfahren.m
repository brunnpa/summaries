function [x,y] = mittelpunktverfahren(f, a, b, n, y0)

    h = (b - a) / n;
    h2 = h/2;
    
    x = a:h:b;
    
    y = [y0];
    
    for i = 2:n+1
        y2 = y(i-1) + h2*f(x(i-1), y(i-1));
        y(i) = y(i-1) + h*f(x(i-1) + h2, y2);
    end

end

