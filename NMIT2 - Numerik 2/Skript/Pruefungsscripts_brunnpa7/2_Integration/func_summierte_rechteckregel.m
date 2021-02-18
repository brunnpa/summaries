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
function [Rf] = func_summierte_rechteckregel(f, a, b, n)

    fprintf('\n\n------------------------------------------------------');
    fprintf('\nBegin Function: func_summierte_rechteckregel(f,a,b,n)\n\n');
    
    h = (b-a)/n;
    
    fprintf('h = (b - a) / n \n');
    fprintf('  = (%.2f - %.2f) / %d \n', b,a,n);
    fprintf('  = %.2f \n\n', h);
    
    xRf = a; % x definieren mit linker Intervallsgrenze als Startwert
    
    for i = 1:n
        if(i == 1)
           xRf = xRf + h/2;
        else
           xRf = xRf + h; % Else the full width h is added
        end
        
        xRf_vals(i) = xRf;
    end

    rfSum = 0; % Variable fuer Rechteckregel Summenbildung

    for i = 1:n
        fxi = f(xRf_vals(i));
        fprintf('%2d: f(%.2f) = %.4f\n',i, xRf_vals(i), fxi);
        rfSum = rfSum + fxi; % Bildung der Summe fuer Rechteckregel
    end
    
    fprintf(' Summe = %.4f\n', rfSum);

    Rf = h * rfSum;
    
    fprintf('\nRf(h) = h * Sum(f(xi + h/2)) \n');
    fprintf('Rf(%.2f) = %.2f * %.4f \n',h, h,rfSum);
    fprintf('Rf(%.2f) = %.4f \n',h, Rf);

    
    
    fprintf('\nEnd Function: func_summierte_rechteckregel(f,a,b,n)\n');
    fprintf('------------------------------------------------------\n');
end