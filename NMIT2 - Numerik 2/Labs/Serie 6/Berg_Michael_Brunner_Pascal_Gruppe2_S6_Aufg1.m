% [x,y] = Berg_Michael_Brunner_Pascal_Gruppe2_S6_Aufg1(@(x,y)x.^2 + 0.1 * y,-1.5,1.5,5,0)

function [x, y] = Berg_Michael_Brunner_Pascal_Gruppe2_S6_Aufg1(f , a, b, n, y0)

h = (b - a)/n;
x = a:h:b;
y = zeros(1, length(x));
y(1) = y0;
for index=1:length(x)-1
    k1 = f(x(index), y(index));
    k2 = f((x(index)+h/2),(y(index)+(h/2)*k1));
    k3 = f((x(index)+h/2),(y(index)+(h/2)*k2));
    k4 = f((x(index)+h),(y(index)+h*k3));
    x(index+1) = x(index)+h;
    y(index+1) = y(index) + h*(1/6)*(k1+2*k2+2*k3+k4);
end

% Check
% Stimmt mit dem Beispiel 7.7 überein

end