f = @(x) 10./(-x.*sqrt(x));
a = 20;
b = 5;
n = 5;

h = (b-a)/n;
Rf = 0;
for i=1:n
    xi = a+(i-1)*h;
    Rf = Rf + f(xi + (h/2));
end

Rf = h * Rf;
disp(Rf);

% Effektiven Wert berechnen
correct = integral(f, a, b);
disp(correct);

% absoluten Fehler berechnen
error = abs(correct - Rf);
disp(error);

%Falls als Funktion gebraucht:
function [Rf] = rechtecksregel(f, a, b, n)
%rechtecksregel Summary of this function goes here
%   Detailed explanation goes here
h = (b-a)/n;
Rf = 0;
for i=1:n
    xi = a+(i-1)*h;
    Rf = Rf + f(xi + (h/2));
end

Rf = h * Rf;

end