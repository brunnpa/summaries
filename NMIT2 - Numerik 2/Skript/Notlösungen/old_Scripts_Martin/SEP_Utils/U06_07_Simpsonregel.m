f = @(x) 10./(-x.*sqrt(x));
a = 20;
b = 5;
n = 5;

h = (b-a)/n;
Sf = 1/2 * f(a) + 1/2 * f(b);

for i=1:(n-1)
    xi = a+i*h;
    Sf = Sf + f(xi);
end

zwischenergebnis = 0;
for i=1:n
    xPrev = a+(i-1)*h;
    xi = a+i*h;
    zwischenergebnis = zwischenergebnis + f((xPrev + xi)/2);
end

Sf = Sf + 2*zwischenergebnis;
Sf = (h/3) * Sf;
disp(Sf);

% Effektiven Wert berechnen
correct = integral(f, a, b);
disp(correct);

% absoluten Fehler berechnen
error = abs(correct - Sf);
disp(error);

%Falls als Funktion gebraucht:
function [Sf] = simpsonregel(f, a, b, n)
%TRAPEZREGEL Summary of this function goes here
%   Detailed explanation goes here
h = (b-a)/n;
Sf = (f(a) + f(b))/2;
for i=1:(n-1)
    xi = a+i*h;
    Sf = Sf + f(xi + (h/2));
end

Sf = h * Sf;

end