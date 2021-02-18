function    [x, y_ab]     =   adams(f, a, b, n, y0, s)
% Test:     [x, y_ab]     =   adams(@(t,yt)yt, 0, 1, 10, 1, 30)
%
% Methode, die mittels des Adam Bashford Mehrschrittvefahrens
% welches ein Polynom an den vorgegebenen Punkten interpoliert.

% Params:
% f:    Zu integrierende Funktion
% a:    Untere Intervallgrenze
% b:    Obere Intervallgrenze
% n:    Schrittanzahl für Integration
% y0:   Startwert
% s:    Stufigkeit der Adams-B Methode
% 
% Returns:
% b:    Koeffizienten

%% Vorraussetzungen
h       =     (b - a) / n;         fprintf("h =  %.4f", h);
x       =     zeros(1, n+1);
y       =     zeros(1,n+1);
y(1)    =     y0;      % Interpolationspolynom

% bei Ordnung 4 mÃ¼ssen die ersten 4 Terme ausgerechnet werden
[x(1:4),y(1:4)] = rk4(f,a,a+3*h,3,y0);
f_val(1:4) = f(x(1:4),y(1:4));


%% Implementierung
for i=s:n
    b = getAdamsB(s);
    sum = 0; 
    x(i+1) = x(i)+h;
    for j=0:(s-1)
        sum = sum + b(j+1)*f(x(i-j), y(i-j));
    end
    y(i+1) = y(i) + h.*sum; 
end

x    = x;
y_ab = y;
end
