% berechnet die Iterationsschritte der Fixpunktiteration für die Funktion
% funcFix
%
% @(x) x^3 + 0.3 als Fixpunktgleichung von @(x) x^3 -x + 0.3
% [result] = fixpunkt_iteration(@(x) x^3 + 0.3, 0, 10)
%
% funcFix = Fixpunktgleichung, die iteriert werden soll
% x0      = startWert der Iteration
% n       = Anzahl Iterationen
%
function [result] = fixpunkt_iteration(funcFix, x0, n)
result=zeros(n,1);
x = x0; 
for i = 1:n 
    x = funcFix(x);
    fprintf('Step %d: %.10f\n', i, x);
    result(i)= x;
end
end




% Dominique Reiser