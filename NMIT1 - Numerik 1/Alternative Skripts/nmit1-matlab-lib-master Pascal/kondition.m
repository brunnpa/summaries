% returned Konditionszahl als Funktion von x
%
% syms x
% y = x^2 * exp(-x);
% K = kondition(y)
% K(1)
%
% func  = Funktion, deren Kondition berechnet werden soll
% K     = Konditionszahl als Funktion K(x)
%
function [K] =  kondition(func)
    func_diff = diff(func);
    syms x;
    
    K = abs(func_diff) * abs(x) / abs(func);
    K = simplify(K, 'Steps', 10);
    K = matlabFunction(K);
end

% Pascal Haupt
