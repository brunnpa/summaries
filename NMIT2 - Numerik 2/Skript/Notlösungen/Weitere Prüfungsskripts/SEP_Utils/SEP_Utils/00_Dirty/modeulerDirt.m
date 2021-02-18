function    [x, y]  =   modeulerDirt(f, a, b, n, y0)
% Test      [x, y]  =   modeulerDirt(f, a, b, n, y0)
% Parameter:
% f:    Funktion
% a:    Anfangsintervall
% b:    End-Intervall
% n:    Anzahl Schritte
% y0:   Anfangswert für y
%
% Alg0rithmus:
%       1) steigung an ausgangs punkt zur y(i+1) wird die durchschn.
%       Steigung an Punkten  x(i),y(i)=k1
%       2) ... und die folgerndre geschätzte Steigung an punkt x(i+1),
%       y(i+1)=k2 herangezogen
%       3) Konsistenzordnugn = Konvergenzordnung = 2
%% Vorraussetzungen
                                        fprintf("a = %.2f,  b = %.2f,  n = %d,  y0 = %.2f\n", a, b, n, y0);  
h  = (b - a) ./ n;                      fprintf("h = (b - a) / n\n"); fprintf('h = (%.2f - %.2f) / %d = %.2f \n\n',b, a, n, h);

y = zeros(1, n+1);
x = zeros(1, n+1);

x(1) = a;            
y(1) = y0;              

fprintf("x_0 = a0 = %.2f\n", a)
fprintf("y_0 = %.2f\n\n", y0); 
%% Algorithmus

for i=1:n
    %klassisches euler verfahren => steigung k1 an x0,y0 => y_euler
    fprintf("------- Schritt %d------- \n", i);
    x(i+1) = x(i) + h;                          fprintf("x_%d = %.4f + %.4f = %.4f\n", i+1, x(i), h,  x(i+1));                                                    
    y_euler = y(i) + h .* f(x(i),y(i));         fprintf("y_euler = %.4f  + %.4f * f(%.4f, %.4f)  = %.4f\n\n", y(i), h, x(i), y(i), y_euler);      
    
    k1 = f(x(i),y(i));                          fprintf("k_%d = f(%.4f, %.4f) = %.4f\n", i, x(i), y(i), k1);
    
    %berechne steigung an zuvor eruiertem punkt, y_euler
    k2 = f(x(i+1),y_euler);                     fprintf("k_%d = f(%.4f, %.4f) = %.4f\n\n",i+1, x(i+1), y_euler, k2);
    %berechnung von y(i) mittels durchschnitt der steigungen
    y(i+1) = y(i) + (h .* (k1+k2)./2);          fprintf("y_%d = %.4f + (%.4f + %.4f) * 0.5 \n",i+1, h, k1, k2);
    
end

end











