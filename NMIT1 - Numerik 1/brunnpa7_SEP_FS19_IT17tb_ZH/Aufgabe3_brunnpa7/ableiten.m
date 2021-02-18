% returned die Ableitung der Funktion func
%
% [funcDiff] = ableiten(@(x) x.^0.3 + x.^0.5 - 0.01 * x)
%
% func     = Funktion, die abgeleitet werden soll
% funcDiff = abgeleteitete Funktion
%
function [funcDiff] =  ableiten(func)
syms y(x)
y(x) = func;
funcDiff = diff(y,x);
end