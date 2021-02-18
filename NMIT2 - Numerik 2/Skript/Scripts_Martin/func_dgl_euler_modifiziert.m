% --------------------------------------------
% Modifiziertes Euler-Verfahren
% f = Differenzialgleichung
% a = Startwert
% b = Endwert
% n = Anzahl Schritte
% y0 = Startwert
% R�ckgabewerte:
% (xi, yi) = n - berechnete Punkte der Funktion
% Aufruf:
% [x,y] = eulerModifiziert(@(t, yt) t.^2 + 0.1 * yt, -1.5, 1.5, 5, 0)
% --------------------------------------------
function [x, y] = func_dgl_euler_modifiziert(f, a, b, n, y0)
    fprintf('\n\n------------------------------------------------------');
    fprintf('\nBegin Function: func_dgl_euler_modifiziert(f, a, b, n, y0)\n\n');
    
    h = (b-a)/n;
    fprintf('h = (b - a) / n \n');
    fprintf('  = (%.2f - %.2f) / %d \n', b,a,n);
    fprintf('  = %.2f \n\n', h);
    
    x = zeros(n+1, 1);
    y = zeros(n+1, 1);

    y(1) = y0;
    x(1) = a;
    
    fprintf('Startwerte:\nx0 = %.4f\ny0 = %.4f\n\n',x(1),y(1));

    for i=1:n
        fprintf('\n------------------------------------------------------------\n');
        k1 = f(x(i), y(i));
        fprintf('k1 = f(x(i), y(i)) = f(%.4f, %.4f) = %.4f\n\n',x(i), y(i), k1);
        
        yEuler = y(i) + h *  k1;
        fprintf('y%d_Euler = f(x(i), y(i)) = f(%.4f, %.4f) = %.4f\n\n',i, x(i), y(i), k1);

        x(i+1) = x(i) + h;
        fprintf('x%d = xi + h = %.4f + %.4f %.4f\n\n',i, x(i), h, x(i+1));

        k2 = f(x(i+1), yEuler);
        fprintf('k2 = f(x(i+1), yEuler) = f(%.4f, %.4f) = %.4f\n\n',x(i+1), x(i+1), k2);

        y(i+1) = y(i) + h * (k1+k2)/2;
        fprintf('y%d = y%d + h * (k1+k2)/2\n',i, i-1);
        fprintf('    = %.4f + %.4f * (%.4f + %.4f)/2\n', y(i), h, k1, k2);
        fprintf('    = %.4f\n\n', y(i+1));

    end
    fprintf('\nEnd Function: func_dgl_euler_modifiziert(f,a,b,n,y0)\n');
    fprintf('------------------------------------------------------\n');
end