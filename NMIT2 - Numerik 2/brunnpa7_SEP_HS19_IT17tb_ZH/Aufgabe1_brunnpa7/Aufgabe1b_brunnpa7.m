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
% Beispielaufruf:  [T,E] = func_romberg_extrapolation(@(x) 1./x, 2, 4, 3)
% 
% maxFx: Maximaler Funktionswert der Funktion im Intervall f(a) bis f(b)
% xForMaxFx: x-Wert bei dem das Maximum maxFx erreicht wurde
% ====================================================================== %
function [T,E] = Aufgabe1b_brunnpa7
    clc;
    A = -6.3;
    B = 5.4*exp(1) -5;
    f = @(v) v / (A - B * v.^2);
    a = 105;
    b = 20;
    max = 3;
    n = 2;
    % Berechnung von h
    h = (b-a)/n;
    % Korrekte Loesung berechnen
    fIntCorrect = @(v) 1 / 2*B * ln(((A-B)*v^2) / ((A-B)*v^2));

    % Vektoren initialisieren
    T = zeros(max+1);
    E = zeros(max+1);

    % Trapezregel definieren
     T1f = @(n, h) func_summierte_trapezregel(f, a, b, n); 

    % Startwerte berechnen
    for i = 1:(max+1)
        n = 2^(i-1);
        h = (b-a)/2^(i-1);
        T(i,1) = T1f(n,h);
        E(i,1) = abs(T(i,1)-fIntCorrect);
        fprintf('T%d0= %.4f\n',i-1, T(i,1));
        fprintf('E%d0= | T%d1 - fexakt | = | %.4f - %.4f | = %.4f\n\n',i-1,i-1, T(i,1), fIntCorrect, E(i,1));

    end

    fprintf('\n\nRomberg Extrapolation:\n\n');
    % Restliche Werte berechnen
    for k = 2:(max+1)
        kReal = k-1;
        for i = 1:(max+1) - kReal
            T(i,k) = (4^kReal * T(i+1, k-1) - T(i, k-1)) / (4^kReal - 1);
            
            fprintf('T%d%d = (4^(k) * T%d%d - T%d%d) / (4^(k) - 1)\n',i-1, k-1,i, k-2, i-1, k-2);
            fprintf('    = (4^(%d) * %.2f - %.2f) / (4^(%d) - 1)\n',k-1,T(i+1, k-1) ,T(i, k-1), k-1);
            fprintf('    = %.4f\n\n', T(i,k));
            E(i,k) = abs(T(i,k)- fIntCorrect );
            fprintf('E%d%d= | T%d%d - fexakt | = | %.4f - %.4f | = %.4f\n\n\n',i-1,k-1,i-1,k-1, T(i,1), fIntCorrect, E(i,1));
        end
    end
end