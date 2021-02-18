% --------------------------------------------
% Mittelpunkt-Verfahren
% f = Differenzialgleichung
% a = Startwert
% b = Endwert
% n = Anzahl Schritte
% y0 = Startwert
% R�ckgabewerte:
% (xi, yi) = n - berechnete Punkte der Funktion
% Aufruf:
% [x,y] = eulerMittelpunkt(@(t, yt) t.^2 + 0.1 * yt, -1.5, 1.5, 5, 0)
% --------------------------------------------
function [x, y] = Aufgabe2d_brunnpa7(f, a, b, n, y0)
    fprintf('\n\n------------------------------------------------------');
    fprintf('\nBegin Function: func_dgl_mittelpunkt(f, a, b, n, y0)\n\n');
    f = @(x,y) x.^2 + y;
    a = 0;
    b = 3;
    y0 = -0.5;
    n =2;
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
       xHalb = x(i) + (h/2);
       fprintf('x%d_(h/2) = x%d + h/2 = %.4f + (%.4f/2) = %.4f\n\n',i,i-1, x(i), h, xHalb);
       
       yHalb = y(i) + (h/2) * f(x(i), y(i));
       fprintf('y%d_(h/2) = y%d + h/2 * f(xi,yi)\n', i, i-1);
       fprintf('        = %.4f + %.4f/2 * f(%.4f, %.4f)\n', y(i), h, x(i), y(i));
       fprintf('        = %.4f + %.4f * %.12f\n', y(i), (h/2), f(x(i), y(i)));
       fprintf('        = %.4f\n\n', yHalb);
       
       x(i+1) = x(i) + h;
       fprintf('x%d = x%d + h = %.4f + %.4f = %.4f\n\n', i, i-1, x(i), h, x(i+1));
       
       y(i+1) = y(i) + h *  f(xHalb, yHalb);
       fprintf('y%d = y%d + h * f(x%d_h/2, y%d_h/2\n',i, i-1,i,i);
       fprintf('    = %.4f + %.4f * f(%.4f, %.4f)\n', y(i), h, xHalb, yHalb);
       fprintf('    = %.4f + %.4f * %.12f\n',y(i), h,f(xHalb, yHalb));
       fprintf('    = %.4f\n',y(i+1));
    end
    
    fprintf('\nEnd Function: func_dgl_mittelpunkt(f,a,b,n,y0)\n');
    fprintf('------------------------------------------------------\n');
end