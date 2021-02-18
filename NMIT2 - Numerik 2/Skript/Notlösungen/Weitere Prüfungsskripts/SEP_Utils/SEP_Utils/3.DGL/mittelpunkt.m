function    [ x, y ]    =   mittelpunkt(f, a, b, n, y0)
% Test      [ x, y ]     =  mittelpunkt(f, a, b, n, y0)
% Parameter:
% f:    Funktion
% a:    Anfangsintervall
% b:    End-Intervall
% n:    Anzahl Schritte
% y0:   Anfangswert für y
%
% Algorithmus:
%       1) von ausgangspunkt wird y_mid in mitte des intervalls geschätzt;
%       2) steigung an punkt (x_mid, y_mid) zur Schätzung von y(i+1)
%       3) Konsistenzordnugn = Konvergenzordnung = 2
%% Vorraussetzungen
                        fprintf("x in [%.2f;%.2f] \n", a,b);
h = (b-a)./n;           fprintf("a = %.2f,  b = %.2f,  n = %d,  y0 = %.2f\n", a, b, n, y0);  
                        fprintf("h = (b - a) / n\n"); fprintf('h = (%.2f - %.2f) / %d = %.2f \n\n',b, a, n, h);


y = zeros(1, n+1);
x = zeros(1, n+1); 

x(1) = a;               fprintf("x_0 = a0 = %.2f\n", a);  
y(1) = y0;              fprintf("y_0 = %.2f\n\n", y0); 

%% Algorithmus

        fprintf("x_h/2 = x(i) + h/2\n");
        fprintf("y_h/2 = y(i) + h/2 * f(x_i, y_i)\n"); 

for i=1:n
    fprintf("\n------- Schritt %d------- \n", i);
    % Schätzung Mittelpunkt
    x_mid = x(i) + h/2;                                                 
    y_mid = y(i) + h/2 * f(x(i), y(i));
    
        fprintf("x_h/2 = %.4f + %.4f = %.4f \n", x(i), h/2, x_mid);
        fprintf("y_h/2 = %.4f + %.4f * f(%.4f, %.4f) = %.4f \n\n", y(i), h/2, x(i), y(i), y_mid);  
    
    
    %Verwende Steigung an Mittelpunkt zur SchÃ¤tzung von y(i+1)
    x(i+1) = x(i) + h;
    y(i+1) = y(i) + h .* f(x_mid,y_mid);
    
        fprintf("x_%d = %.4f + %.4f = %.4f \n", i+1, x(i), h,  x(i+1));
        fprintf("y_%d = %.4f  + %.4f * f(%.4f, %.4f)  = %.4f\n\n", i+1, y(i), h, x_mid, y_mid, y(i+1));
end

end

