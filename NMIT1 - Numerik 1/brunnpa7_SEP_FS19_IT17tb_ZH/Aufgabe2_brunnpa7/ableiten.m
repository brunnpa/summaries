% returned die Ableitung der Funktion func
%
% [funcDiff] = ableiten(@(x) x.^2 / (1-x.^2))
%
% func     = Funktion, die abgeleitet werden soll
% funcDiff = abgeleteitete Funktion
%
function [funcDiff] =  ableiten(func)
syms y(x)
y(x) = func;
funcDiff = diff(y,x);
end