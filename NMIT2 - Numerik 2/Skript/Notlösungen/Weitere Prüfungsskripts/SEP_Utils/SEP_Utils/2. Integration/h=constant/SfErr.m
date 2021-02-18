function [max_err] = SfErr(a, b, h, f, step)
%max_error = SfErr(0, 0.5, [1/4, 1/8, 1/16, 1/32, 1/64], @(x)x^5, 0.001)
%           
%           Berechnet den maximalen Fehler der summierten Simpson-Regel
% Params:   
% a:    untere Intervallgrenze    
% b:    obere Intervallgrenze
% h:    Schrittweiten die zu analysieren sind
% f:    Funktion die zu betrachten ist für das jeweilige Verfahren
% step: Schrittweite des Eingabepparameters (x)

% Hilfswerte
fdiff4  = diff4(f);
x       = a:step:b;
y       = fdiff4(x);
% Kalkulation
max_err = (h.^4 ./ 2880).*(b-a).*abs(max(y));

% Darstellung
labels = ["h";"max_err"];
results = [string(h); string(max_err)];
results = [labels, results];
disp(results);
end

