% NMIT2 SEP - Aufgabe 2c
% Valmir Selmani

f = @(t, yt) t - yt;
a = 0;
b = 0.5;
n = 1;
y0 = 2;

[x,y] = runge_kutta(f, a, b, n, y0);
plot(x,y);

function [x, y] = runge_kutta(f, a, b, n, y0)
    h = (b-a)/n;

    x = zeros(n+1, 1);
    y = zeros(n+1, 1);

    y(1) = y0;
    x(1) = a;

    for i=1:n
        k1 = f(x(i), y(i));
        k2 = f(x(i) + h/2, y(i) + h/2 * k1);
        k3 = f(x(i) + h/2, y(i) + h/2 * k2);
        k4 = f(x(i) + h, y(i) + h * k3);
        
       x(i+1) = x(i) + h;
       y(i+1) = y(i) + h *  (1/6) * (k1 + 2*k2 + 2*k3 + k4);
    end
end