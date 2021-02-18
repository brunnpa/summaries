% [x,y] = Berg_Michael_Gruppe2_S8_Aufg2(@(x,y)x.^2 + 0.1 * y,-1.5,1.5,5,0)

function [x, y] = runge_kutta_4(f , a, b, n, y0)
    h = (b - a)/n;
    x = a:h:b;
    s = size(y0, 1);
    y(1:s, 1) = y0;
    
    for index=1:length(x)-1
        k1 = f(x(index), y(1:s, index));
        k2 = f((x(index)+h/2),(y(1:s, index)+(h/2).*k1));
        k3 = f((x(index)+h/2),(y(1:s, index)+(h/2).*k2));
        k4 = f((x(index)+h),(y(1:s, index)+h.*k3));
        x(index+1) = x(index)+h;
        y(1:s, index+1) = y(1:s, index) + h*(1/6).*(k1+2*k2+2*k3+k4);
    end

end