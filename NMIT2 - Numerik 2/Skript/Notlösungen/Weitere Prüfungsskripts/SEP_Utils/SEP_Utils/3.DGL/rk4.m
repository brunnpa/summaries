function    [x, y]  =   rk4(f, a, b, n, y0)
% Parameter:
% f:    Funktion
% a:    Anfangsintervall
% b:    End-Intervall
% n:    Anzahl Schritte
% y0:   Anfangswert f�r y
%
% Algorithmus:
%       1) von ausgangspunkt wird y_mid in mitte des intervalls gesch�tzt;
%       2) steigung an punkt (x_mid, y_mid) zur Sch�tzung von y(i+1)
%       3) Es werden wdie Steigung der Geraden K2 gherangezogen
%       4) K3 wird basierend auf K2 ab dem Mittelpunkt approx.
%       5) k4 wird basierend auf K3 ab dem Mittelpunkt approx.
h = (b-a)./n;       fprintf("a = %.2f,  b = %.2f,  n = %d,  y0 = %.2f\n", a, b, n, y0); 
                    fprintf("h = (b - a) / n\n"); fprintf('h = (%.2f - %.2f) / %d = %.2f \n\n',b, a, n, h);
if numel(y0) == 1
    y       = zeros(1, n+1);         
    x       = zeros(1, n+1);        
    x(1)    = a;   
    y(1)    = y0;
    
        fprintf("x_0 = a0 = %.2f\n", a)
        fprintf("y_0 = %.2f\n\n", y0); 
    
    %Steigung an x(0),y(0)
    for i=1:n
            fprintf("------- Schritt %d------- \n", i);
        %Steigung an Ausgangspunkt
        k1 = f(x(i),y(i));
        fprintf("k_1 = f(%.4f, %.4f) = %.4f\n", x(i), y(i), k1);
        %Steigung in Mitte mittels k1
        k2 = f(x(i)+(h/2),y(i)+(h/2)*k1);
        fprintf("k_2 = f(%.4f + (%.4f / 2), %.4f + (%.4f / 2) ) * %.4f)  = %.4f\n", x(i), h, y(i), h, k1, k2);
        %Steigung in Mitte mit k2
        k3 = f(x(i)+(h/2),y(i)+(h/2)*k2);
        fprintf("k_3 = f(%.4f + (%.4f / 2), %.4f + (%.4f / 2) * %.4f)  = %.4f\n", x(i), h, y(i), h, k2, k3);
        %Steigung Endpunkt mit k3
        k4 = f(x(i)+h,y(i)+(h.*k3));
        fprintf("k_4 = f(%.4f + %.4f, %.4f + %.4f * %.4f)  = %.4f\n", x(i), h, y(i), h, k3, k4);
        x(i+1) = x(i) + h;
        fprintf("x_%d = %.4f + %.4f = %.4f \n", i+1, x(i), h, x(i+1));
        y(i+1) = y(i) + (h.*(1./6).*(k1 + 2.*k2 + 2.*k3 + k4));
        fprintf("y_%d = %.4f + %.4f * 1/6 * ( %.4f + 2*%.4f + 2*%.4f +  %.4f ) =  %.4f \n", i+1, y(i), h, k1, k2, k3, k4, y(i+1));
    end
elseif size(y0,1) > 1
    x = a:h:b;
    n = size(x,2);
    y = zeros(size(y0,1),n);
    y(:,1) = y0;
    for i=1:(n-1)             
        %Steigungen an Ausgangspunkt
        k1 = f(x(i),y(:,i));
        %Steigungen in Mitte mittels k1
        k2 = f(x(i)+(h/2),y(:,i)+(h/2)*k1);
        %Steigungen in Mitte mit k2
        k3 = f(x(i)+(h/2),y(:,i)+(h/2)*k2);
        %Steigungen Endpunkt mit k3
        k4 = f(x(i)+h,y(:,i)+(h.*k3));
        y(:,i+1) = y(:,i) + (h./6).*(k1 + 2.*k2 + 2.*k3 + k4);   
    end
elseif size(y0,2) > 1
    error("input-Vektor muss Spalten-Vektor sein");


end