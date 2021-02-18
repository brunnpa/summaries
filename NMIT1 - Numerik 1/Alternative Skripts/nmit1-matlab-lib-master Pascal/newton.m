% berechnet die Iterationsschritte des Newton-Verfahren für die Funktion
% func
%
% [result] = newton(@(x) x^2 - 2, 2, 4, false)
%
% func     = Funktion, die iteriert werden soll
% x0       = startWert der Iteration
% n        = Anzahl Iterationen
% easyMode = boolean ob nach vereinfachtem Newton-Verfahren rechnen soll
%
function [result] = newton(func, x0, n, easyMode)
result=zeros(n,1);
funcDiff = ableiten(func);
x = x0; 
diff_x0 = funcDiff(x0);

for i = 1:n 
    if(easyMode)
        x = x - (func(x) / diff_x0);
    else
        x = x - (func(x) / funcDiff(x));
    end
   
    fprintf('Step %d: %.10f\n', i, x);
    result(i) =x;
end
end



% Dominique Reiser