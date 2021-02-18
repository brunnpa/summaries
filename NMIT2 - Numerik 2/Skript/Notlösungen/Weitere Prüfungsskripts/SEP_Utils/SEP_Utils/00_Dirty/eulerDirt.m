
function    [x, y]  =   eulerDirt(f, a, b, n, y0)
% Test      [x, y]  =   eulerDirt((@(x,y)x.^2+0.1*y),-1.5,1.5,10,1)
% Parameter:
% f:    Funktion
% a:    Anfangsintervall
% b:    End-Intervall
% n:    Anzahl Schritte
% y0:   Anfangswert für y
%
% Alg0rithmus:
%       1) steigung an ausgangs punkt zur direkten eruierung von y(i+1)
%       2) mittels Taylor kann gezeigt werden: lokaler Fehler phi(xn,h)=h^2/2.*y''(x) 
%       3) => Konsistenzordnung p=1
%       4) globaler Fehler => Konvergenzordnung = 1

%% Vorraussetzungen
                                        fprintf("a = %.2f,  b = %.2f,  n = %d,  y0 = %.2f\n", a, b, n, y0);  
h  = (b - a) ./ n;                      fprintf("h = (b - a) / n\n"); fprintf('h = (%.2f - %.2f) / %d = %.2f \n\n',b, a, n, h);

%% Skalare Lösung
if numel(y0) == 1
    y       = zeros(1, n+1);            
    x       = zeros(1, n+1);
    x(1)    = a;                fprintf("x_0 = a0 = %.2f\n", a);                           
    y(1)    = y0;               fprintf("y_0 = %.2f\n\n", y0); 
    
    fprintf("x_i+1 = x_i + h \n");
    fprintf("y_i+1 = y_i + h * f(x_i, y_i \n\n");    
    for i=1:n
        fprintf("------- Schritt %d------- \n", i);
        x(i+1) = x(i) + h;                          fprintf("x_%d = %.4f + %.4f = %.4f\n", i+1, x(i), h,  x(i+1));                                                    
        y(i+1) = y(i) + h .* f(x(i),y(i));          fprintf("y_%d = %.4f  + %.4f * f(%.4f, %.4f)  = %.4f\n", i+1, y(i), h, x(i), y(i), y(i+1));      
    end
    
%% Vektorielle Lösung
elseif size(y0,1) > 1
    
    x       = a:h:b;                % Aufspalten des Intervalles in diskrete x-Werte
    n       = size(x,2);
    y       = zeros(size(y0,1),n);
    y(:,1) = y0;
    
    for i=1:(n-1)
        y(:,i+1) = y(:,i) + h.*f(x(i),y(:,i));
    end
elseif size(y0,2) > 1
    error("input-Vektor muss Spalten-Vektor sein");
end

end

