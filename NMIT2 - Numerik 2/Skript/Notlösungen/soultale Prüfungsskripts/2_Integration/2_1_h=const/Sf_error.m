function [max_err] = Sf_error(a, b, h, fdiff4, step)
%max_error = Sf_error(0, 0.5, [1/4, 1/8, 1/16, 1/32, 1/64], @(x)12'.*x, 0.001)
%Maximaler Fehler bei Simpson-Regel
%f:x^5
%fdiff1: 5x^4
%fdiff2: 20x^3
%fdiff3: 60x^2
%fdiff4: 1120x
%a: untere Intervallgrenze 
%b: obere Intervallgrenze
%h: Schrittweite
%fdiff4: 4te Ableitung von f
%step: Schrittweite für Suche von Maximum

x = a:step:b;
y = fdiff4(x);
max_err = (h.^4 ./ 2880).*(b-a).*abs(max(y));
labels = ["h";"max_err"];
results = [string(h); string(max_err)];
results = [labels, results];
%disp(results);
end

