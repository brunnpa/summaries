function [max_err] = Tf_error(a, b, h, fdiff2, step)
%bestimmtes Integral von a=0 bis b=0.5
%Funktion f = @(x)exp(1).^(-x.^2)
%fdiff1 berechnen: exp(1).^(-x.^2)*-2x
%fdiff2 berechnen: @(x)exp(1).^(-x.^2).*4.*x.^2 + -2.*exp(1).^(-x.^2)
%Fehler soll maximal 10^-5 betragen:
%h so wählen, dass dies erfüllt ist
%max_error = Tf_error(0, 0.5, [1/4, 1/8, 1/16, 1/32, 1/64], @(x)exp(1).^(-x.^2).*4.*x.^2 - 2.*exp(1).^(-x.^2), 0.001)
%Maximaler Fehler bei Trapezregel
%a: untere Intervallgrenze 
%b: obere Intervallgrenze
%h: Schrittweite
%fdiff2: 2te Ableitung von f
%step: Schrittweite für Suche von Maximum

x = a:step:b;
y = fdiff2(x);
max_err = (h.^2 ./ 12).*(b-a).*abs(max(y));
labels = ["h";"max_err"];
results = [string(h); string(max_err)];
results = [labels, results];
%disp(results);
end


