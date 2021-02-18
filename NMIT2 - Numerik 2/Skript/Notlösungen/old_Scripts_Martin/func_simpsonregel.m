% ====================================================================== %
% Funktion: Summierte Rechteckregel
%
% Beschreibung:
% Die Funktion die 
% 
% a: untere Intervallsgrenze
% b: obere Intervallsgrenze
% f: Funktion von dem das Maximum bestimmt werden soll
% 
% Beispielaufruf:  [maxFx, xForMaxFx] = func_maximum(1, 2, @(x) log(x^2))
% 
% maxFx: Maximaler Funktionswert der Funktion im Intervall f(a) bis f(b)
% xForMaxFx: x-Wert bei dem das Maximum maxFx erreicht wurde
% ====================================================================== %
function [Sf] = func_simpsonregel(f, a, b, n)

    fprintf('\n\n------------------------------------------------------');
    fprintf('\nBegin Function: func_summierte_simpsonregel(f,a,b,n)\n\n');
 
    h = (b-a)/n;
    
    fprintf('h = (b - a) / n \n');
    fprintf('  = (%.2f - %.2f) / %d \n', b,a,n);
    fprintf('  = %.2f \n\n', h);

    
    SfInner = (f(a) + f(b))/2;
    SfSum = 0;
    for i=1:(n-1)
        xi = a+i*h;
        fxi = f(xi + (h/2));
        fprintf('%2d: f(%.2f + (%.2f/2)) = f(%.f) = %.4f\n',i, xi, h, xi + (h/2), fxi);
        SfSum = SfSum + fxi;
    end
    fprintf(' Summe = %.4f\n', SfSum);

    Sf = h * (SfInner + SfSum);
    
    fprintf('\nSf(h) = h * ( ( f(a) + f(b) ) / 2) + Sum(f(xi) + (h/2)) ) \n');
    fprintf('Sf(%.2f) = %.2f * ( ( f(%.2f) + f(%.2f) ) / 2) + %.4f)) \n',h, h, a, b,SfSum);
    fprintf('Sf(%.2f) = %.2f * ( %.4f + %.4f ) \n',h ,h, SfInner,SfSum);
    fprintf('Sf(%.2f) = %.4f \n',h, Sf);


    fprintf('\nEnd Function: func_summierte_simpsonregel(f,a,b,n)\n');
    fprintf('------------------------------------------------------\n');
end