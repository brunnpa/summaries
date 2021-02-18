% --------------------------------------------
% Klassisches Euler-Verfahren
% f = Differenzialgleichung
% a = Startwert
% b = Endwert
% n = Anzahl Schritte
% y0 = Startwert
% R�ckgabewerte:
% (xi, yi) = n - berechnete Punkte der Funktion
% Aufruf:
% [x,y] = dgl_euler_klassisch(@(t, yt) t.^2 + 0.1 * yt, -1.5, 1.5, 5, 0)
% --------------------------------------------
function [x, y] = func_dgl_euler_klassisch(f, a, b, n, y0)
    fprintf('\n\n------------------------------------------------------');
    fprintf('\nBegin Function: func_dgl_euler_klassisch(f, a, b, n, y0)\n\n');
    
    h = (b-a)/n;
    fprintf('h = (b - a) / n \n');
    fprintf('  = (%.2f - %.2f) / %d \n', b,a,n);
    fprintf('  = %.2f \n\n', h);
    
    x = zeros(n+1, 1);
    y = zeros(n+1, 1);
    
    y(1) = y0;
    x(1) = a;

    fprintf('Formel:\nx(i+1) = xi + h\ny(i+1) = y(i) + h * f(xi,yi)\n\n');
    fprintf('Startwerte:\nx0 = %.4f\ny0 = %.4f\n\n',x(1),y(1));
 
    
    for i=1:n
       % Formel zur numerischen Berechnung siehe Skriptum Seite 115
       x(i+1) = x(i) + h;
       fprintf('x%d = %.4f + %.4f = %.4f\n',i, x(i), h, x(i+1));
       y(i+1) = y(i) + h *  f(x(i), y(i));
       fprintf('f(x%d,y%d) = f(%.4f, %.4f) = %.4f\n', i-1, i-1,x(i), y(i), f(x(i), y(i)));
       fprintf('y%d = %.4f + %.4f * f(%.4f, %4f) = %.4f\n\n',i, y(i), h,x(i), y(i), y(i+1));
    end 
end

