function [y0, e0, y1, e1, y2, e2, y3, e3] = a1()

% The function returns the extrapolations and discrete errors for the
% function f(x) = ln(x^2) and an x0 = 2

format long;

x0 = 2;

for i = 1:4
    h = 0.1/2^(i-1);
    y0(i) = (log((x0 + h)^2) - log(x0^2)) / h;
    e0(i) = abs((log((x0 + h)^2) - log(x0^2)) / h - 1);
end

for i = 1:3
    y1(i) = 2*y0(i+1) - y0(i);
    e1(i) = abs(2*y0(i+1) - y0(i) - 1);
end

for i = 1:2
    y2(i) = (4*y1(i+1) - y1(i)) / 3;
    e2(i) = abs((4*y1(i+1) - y1(i)) / 3 - 1);
end

y3 = (8*y2(2) - y2(1)) / 7;
e3 = abs((8*y2(2) - y2(1)) / 7 - 1);
