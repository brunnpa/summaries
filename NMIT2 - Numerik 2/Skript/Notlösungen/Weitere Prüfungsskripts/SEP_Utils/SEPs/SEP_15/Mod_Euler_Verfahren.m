function [ x,y ] = Mod_Euler_Verfahren( func, x0, y0, n, a, b )

h = (b-a)/n;
x = zeros(n+1,1);
y = zeros(n+1,1);
x(1) = x0;
y(1) = y0;

for i = 1:1:n
    x(i+1) = x(i) + h;
    yeuler = y(i) + (h*func(x(i), y(i)));
    k1 = func(x(i), y(i));
    k2 = func(x(i+1), yeuler);
    y(i+1) = y(i) + (h*((k1+k2)/2)); 
end

end