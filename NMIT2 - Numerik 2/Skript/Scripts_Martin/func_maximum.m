% ====================================================================== %
% Funktion: maximum
%
% Beschreibung:
% Die Funktion liefert den maximalen Funktionswert (y) einer uebergebenen
% Funktion (f) inklusive dem x-Wert an dem das Maximum erreicht wurde
% zurueck
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

function [maxFx, xForMaxFx] = func_maximum(a,b,f)
    
    %Define the interval over which f(x) will be evaluated
    xInterval = [a b];
    
    % Schrittweite von x-Wert im Intervall zwischen a und b
    % TODO: wenn genauer oder ungenauer einfach den Wert anpassen
    resolution = 0.0001;
    
    %Create a vector of x values based on the interval of evaluateion and
    %resolution specifications
    x = xInterval(a): resolution : xInterval(b);
    
    %Calculate f(x) values
    for i = 1:length(x)
        fx(i) = abs(f(x(i)));
    end
    [M,idx] = max(fx);

    maxFx = M;
    xForMaxFx = x(idx);
end
