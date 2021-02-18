function    [max_err]   =   RfErr(a, b, h, f, step)
% Test:     [max_err]   =   RfErr(0, 0.5, [1/4, 1/8, 1/16, 1/32, 1/64], @(x)exp(1).^(-x.^2), 0.001)
%           
%           Berechnet den maximalen Fehler der summierten Rechteckregel
% Params:   
% a:    untere Intervallgrenze    
% b:    obere Intervallgrenze
% h:    Schrittweiten die zu analysieren sind
% f:    Funktion die zu betrachten ist für das jeweilige Verfahren
% step: Schrittweite des Eingabepparameters (x)

% Hilfsvariablen
fdiff2  = diff2(f);
x       = a:step:b;
y       = fdiff2(x);

% Kalkulation
max_err = (h.^2 ./ 24).*(b-a).*abs(max(y));

% Darstellung
labels = ["h";"max_err"];
results = [string(h); string(max_err)];
results = [labels, results];
disp(results);
end
