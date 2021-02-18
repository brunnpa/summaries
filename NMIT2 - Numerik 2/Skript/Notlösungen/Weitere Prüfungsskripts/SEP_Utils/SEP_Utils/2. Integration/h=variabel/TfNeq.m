function    [Tf_neq]    =   TfNeq(x, y)
% Test:     [Tf_new]    =   TfNeq([1:0.01:2], log([1:0.01:2]))
%
% Berechnet den Integral einer tabellarischen Funktoin 
% mithilfe der summierte Trapezregel 
% Params:
% x     =   Vektor mit den X-Werten
% y     =   Vektor mit den Y-Werten

Tf_neq = 0;
for i=1:(length(x)-1)
    Tf_neq = Tf_neq + ((y(i) + y(i+1))/2 * (x(i+1) - x(i)));
end

