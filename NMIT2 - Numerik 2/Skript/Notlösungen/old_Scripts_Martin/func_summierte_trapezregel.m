% Berechnet die Integration einer stetigen Funktion mithilfe der
% Trapezregel
% f = Funktion, die integriert werden soll
% a = Startwert Bereich
% b = Endwert Bereich
% n = Anzahl Startwerte (0, ... , n)
function [Tf] = func_summierte_trapezregel(f, a, b, n)

    fprintf('\n\n------------------------------------------------------');
    fprintf('\nBegin Function: func_summierte_trapezregel(f,a,b,n)\n\n');
    h = (b-a)/n;
    
    fprintf('h = (b - a) / n \n');
    fprintf('  = (%.2f - %.2f) / %d \n', b,a,n);
    fprintf('  = %.2f \n\n', h);

    TfInner = (f(a) + f(b))/2;
    TfxiSum = 0;
    for i=1:(n-1)
        fxi = f(a+i*h);
        fprintf('%2d: f(%.2f) = %.4f\n',i, a+i*h, fxi);
        TfxiSum = TfxiSum + fxi;
    end
    fprintf(' Summe = %.4f\n', TfxiSum);

    Tf = h * (TfInner + TfxiSum);
    
    fprintf('\nTf(h) = h * ( ( f(a) + f(b) ) / 2) + Sum(f(xi)) ) \n');
    fprintf('Tf(%.2f) = %.2f * ( ( f(%.2f) + f(%.2f) ) / 2) + %.4f)) \n',h, h, a, b,TfxiSum);
    fprintf('Tf(%.2f) = %.2f * ( %.4f + %.4f ) \n',h ,h, TfInner,TfxiSum);
    fprintf('Tf(%.2f) = %.4f \n',h, Tf);

    
    
    fprintf('\nEnd Function: func_summierte_trapezregel(f,a,b,n)\n');
    fprintf('------------------------------------------------------\n');
end