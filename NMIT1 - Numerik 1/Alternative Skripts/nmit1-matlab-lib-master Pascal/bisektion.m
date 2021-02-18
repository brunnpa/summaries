%   Berechnet die Nullstelle im vorgebenen Intervall mit hilfe des
%   Bisektionsverfahren

%   [root, xit, n] = bisektion(@(x) cos(x).*sin(x),1,2,0.001,0)
%
%   func = Funktion für die, die Nullstelle berechnet werden soll
%   a    = intervall start
%   b    = intervall ende
%   tol  = toleranz in für akzeptant des ergebnis
%   n    = startwert für iterationscounter = 0
%   xit  = übergabehilfswert für rekursive lösung der aufgabe speichert alle
%   berechneten 
%   root = nullstelle an position x

function [root, xit, n] = bisektion(func, a, b , tol, n, xit)

af = func(a);
bf = func(b);
x = (a + b) / 2;
xf = func(x);
n = n + 1;

xit(n) = x;

if((af * xf) < 0)
    b = x;
else
    a = x;
end

if (abs(af - bf) > tol)
    [root, xit, n] = bisektion(func, a, b, tol, n, xit);
else
    root = x;
end 

end



% Pascal Fivian
