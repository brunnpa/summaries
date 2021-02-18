% NMIT2 SEP - Aufgabe 2b
% Valmir Selmani

f = @(t, yt) t - yt;
a = 0;
b = 1;
n = 2;
y0 = 2;

[x,y] = eulerKlassisch(f, a, b, n, y0);
plot(x,y);

function [x, y] = eulerKlassisch(f, a, b, n, y0)
    h = (b-a)/n;

    x = zeros(n+1, 1);
    y = zeros(n+1, 1);

    y(1) = y0;
    x(1) = a;

    for i=1:n
       x(i+1) = x(i) + h;
       y(i+1) = y(i) + h *  f(x(i), y(i));
    end
end