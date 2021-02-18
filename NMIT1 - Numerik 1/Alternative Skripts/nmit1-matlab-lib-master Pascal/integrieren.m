% returned die Integration der Funktion func
%
% [funcInt] = integrieren(@(x) x.^5 - 5*x.^4 - 30*x.^3 + 110*x.^2 + 29*x - 105)
%
% func    = Funktion, die integriert werden soll
% funcInt = integrierte Funktion
%
function [funcInt] =  integrieren(func)
syms y(x)
y(x) = func;
funcInt = matlabFunction(int(y,x));
end



% Dominique Reiser