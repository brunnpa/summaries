f = @(x) 10./(-x.*sqrt(x));
a = 20;
b = 5;
n = 5;

h = (b-a)/n;
Tf = (f(a) + f(b))/2;
for i=1:(n-1)
    Tf = Tf + f(a+i*h);
end

Tf = h * Tf;
disp(Tf);

% Effektiven Wert berechnen
correct = integral(f, a, b);
disp(correct);

% absoluten Fehler berechnen
error = abs(correct - Tf);
disp(error);

%Falls als Funktion gebraucht:
function [Tf] = trapezregel(f, a, b, n)
%TRAPEZREGEL Summary of this function goes here
%   Detailed explanation goes here
h = (b-a)/n;
Tf = (f(a) + f(b))/2;
for i=1:(n-1)
    Tf = Tf + f(a+i*h);
end

Tf = h * Tf;

end