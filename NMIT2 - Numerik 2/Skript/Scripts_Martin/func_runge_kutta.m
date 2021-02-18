% ====================================================================== %
% Funktion: Runge Kutta Verfahren
% 
% Beschreibung: Die Funktion loest die Funktion mittels Runga-Kutta
%               Verfahren und retourniert die entsprechenden x und y Werte
%
% f: Funktion
% a: Untere Intervallsgrenze
% b: Obere Intervallsgrenze
% n: Anzahl der Subintervalle bzw. Anzahl der Schritte
% y0: Startwert
%
% Beispiel: 
% [x_runge_kutta, y_runge_kutta] = func_runge_kutta(@(x,y)x.^2 + 0.1 * y, -1.5, 1.5, 5, 0)
% ====================================================================== %


function [x, y] = func_runge_kutta(f, a, b, n, y0)
    % h ist so laut Definition 7.7.1 definiert
    h = (b - a)/n;
    
    % x wird mit Werten von a bis b mit h-Abstand aufgef�llt
    x = a:h:b;
    
    % y initialisieren und y(1) mittels Parameter setzen
    y = zeros(1, length(x));
    y(1) = y0;
    
    % Runge-Kutta Verfahren aus dem Skript �bernommen
    for i = 1:length(x)-1
        fprintf('\n\n------------------------------------------------\n');
        k1 = f(x(i), y(i));
        fprintf('k1 = f(x%d,y%d) = f(%.4f, %.4f) = %.4f\n\n', i-1, i-1, x(i), y(i), k1);
        
        k2 = f((x(i)+h/2), (y(i)+(h/2)*k1));
        fprintf('k2 = f(x%d+h/2,y%d+h/2*k1) = f(%.4f, %.4f) = %.4f\n\n', i-1, i-1,x(i)+h/2, y(i)+(h/2)*k1, k1);
        
        k3 = f((x(i)+h/2), (y(i)+(h/2)*k2));
        fprintf('k3 = f(x%d+h/2,y%d+h/2*k2) = f(%.4f, %.4f) = %.4f\n\n', i-1, i-1,x(i)+h/2, y(i)+(h/2)*k2, k2);
        
        k4 = f((x(i)+h), (y(i)+h*k3));
        fprintf('k4 = f(x%d+h,y%d+h/2*k3) = f(%.4f, %.4f) = %.4f\n\n', i-1, i-1,x(i)+h, y(i)+h*k3, k3);

        x(i+1)  = x(i)+h;
        fprintf('x%d = x%d + h = %.4f + %.4f = %.8f\n\n',i, i-1, h, x(i), x(i+1));
        
        y(i+1) = y(i) + h*(1/6)*(k1+2*k2+2*k3+k4);
        fprintf('y%d = y%d + h * (1/6) * (k1 + 2*k2 + 2*k3 + k4)\n', i, i-1);
        fprintf('    = %.4f + %.4f * (1/6) * (%.4f + 2*%.4f + 2*%.4f + %.4f)\n', y(i), h, k1, k2, k3, k4);
        fprintf('    = %.4f\n', y(i+1));
    end
end

%{
Das Resultat im y-Vektor stimmt �berein mit den y_i Werten im Beispiel 7.7.
Die Werte im x-Vektor stimmen �berein mit den t_i Werten im Beispiel 7.7.
%}

