function [max_err] = Rf_error(a, b, h, fdiff2, step)
%max_error = Rf_error(0, 0.5, [1/4, 1/8, 1/16, 1/32, 1/64], @(x)exp(1).^(-x.^2).*4.*x.^2 - 2.*exp(1).^(-x.^2), 0.001)
%Maximaler Fehler
%a: untere Intervallgrenze 
%b: obere Intervallgrenze
%h: Schrittweite
%fdiff2: 2te Ableitung von f
%step: Schrittweite für Suche von Maximum

x = a:step:b;
y = abs(fdiff2(x));
[y_max,index] = max(y);
max_err = (h.^2 ./ 24).*(b-a).*x(index);
labels = ["h";"max_err"];
results = [string(h); string(max_err)];
results = [labels, results];
%disp(results);
end

