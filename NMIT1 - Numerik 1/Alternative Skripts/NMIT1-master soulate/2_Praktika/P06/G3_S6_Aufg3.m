% f = @(x) x
function [y] = G3_S6_Aug3(f, x0, x1, tol)
x2 = 0;
diff = tol + 1;
while diff > tol
    x2 = x1 - ((x1-x0)/(f(x1)-f(x0))) *f(x1)
    diff = abs(x2-x1);
    x0 = x1;
    x1 = x2;
end
y = x2;
end

% Das Newtonverfahren benötigt die Ableitung der Funktion, sprich
% man müsste für jede Funktion die Ableitung in Matlab berechnen, 
% was mit all den Ableitungsregeln schnell komplex wird. 