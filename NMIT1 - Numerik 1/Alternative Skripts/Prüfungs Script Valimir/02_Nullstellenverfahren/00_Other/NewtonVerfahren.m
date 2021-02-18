% Funktion NewtonVerfahren(func,a,b,tol)
% Implentierung des Standard Newton-Verfahrens.
% Beispielaufruf: [root,xit,n] = NewtonVerfahren(@(x) 1/4*x.^(2)-3.*x-25,1.5,1e-12)

function [root,xit,n] = NewtonVerfahren(func,x0,tol)

    format compact; format shortE; clc;
    
    syms x
    f(x) = sym(func);
    df = diff(f);
    if df(sym(x0)) == 0
        error('Ungeeigneter Startwert x0');
    end

    xit = [inf x0];
    x = x0;
    n = 0;
    while (abs(xit(length(xit)-1) - xit(length(xit))) > tol)
        xn = double(x - (f(x) / df(x)));
        xit = [xit xn];
        x = xn;
        n = n+1;
    end
    root = xit(length(xit));
    
end