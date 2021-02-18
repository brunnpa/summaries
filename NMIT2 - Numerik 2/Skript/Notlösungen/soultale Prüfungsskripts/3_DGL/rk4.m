function [x, y] = rk4(f,a,b,n,y0)
%RK4 Klassisches 4 Stufiges Runge Kutta Verfahren
% nur Bsp.: @(x,y)x.^2+0.1*y
%   Detailed explanation goes here
h = (b-a)./n;

if numel(y0) == 1
    y = zeros(1, n+1);
    x = zeros(1, n+1);
    x(1) = a;   
    y(1) = y0;
    %Steigung an x(0),y(0)
    for i=1:n
        %Steigung an Ausgangspunkt
        k1 = f(x(i),y(i));
        %Steigung in Mitte mittels k1
        k2 = f(x(i)+(h/2),y(i)+(h/2)*k1);
        %Steigung in Mitte mit k2
        k3 = f(x(i)+(h/2),y(i)+(h/2)*k2);
        %Steigung Endpunkt mit k3
        k4 = f(x(i)+h,y(i)+(h.*k3));
        x(i+1) = x(i) + h;
        y(i+1) = y(i) + (h.*(1./6).*(k1 + 2.*k2 + 2.*k3 + k4));   

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

% f_exakt = @(x) -10*x.^2 - 200*x - 2000 + 1722.5 * exp(0.05*(2*x+3));
% y_exakt = f_exakt(x)
% plot(x,y);
% hold on
% plot(x,y_exakt);
% legend('Rungens','Exakt');

end

