function [ x,y ] = RungeKutta_Verfahren(func, x0, y0, n, a, b )

h = (b-a)/n;
x = zeros(n+1,1);
y = zeros(n+1,1);
x(1) = x0;
y(1) = y0;

for i = 1:1:n
    k1 = func(x(i), y(i));
    k2 = func(x(i)+(h/2), y(i)+((h/2)*k1));
    k3 = func(x(i)+(h/2), y(i)+((h/2)*k2));
    k4 = func(x(i)+h, y(i)+(h*k3));
    x(i+1) = x(i) + h;
    y(i+1) = y(i) + h*(1/6)*(k1+(2*k2)+(2*k3)+k4); 
end

end

