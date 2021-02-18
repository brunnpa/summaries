% returned die Ableitung der Funktion func
%
% [funcDiff] = ableiten(@(x) x.^5 - 5*x.^4 - 30*x.^3 + 110*x.^2 + 29*x - 105)
%
% func     = Funktion, die abgeleitet werden soll
% funcDiff = abgeleteitete Funktion
%
function [funcDiff] =  ableiten(func)
syms y(x)
y(x) = func;
funcDiff = matlabFunction(diff(y,x));
end


% Dominique Reiser