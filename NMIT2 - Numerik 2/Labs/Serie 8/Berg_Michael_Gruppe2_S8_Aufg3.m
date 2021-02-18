function [] = Berg_Michael_Gruppe2_S8_Aufg3()
    f = @(t,y) -12*y + 30*exp(-2*t);
    a = 0;
    b = 10;
    n = 1000;
    x = a;
    y0 = 0;
    h = (a - b)/n;
    tol = 1e-3;
    h_tab = h;
    y_euler = y0;
    y_mittelpunkt = y0;
    x_h2 = 0;
    y_h2 = 0;
    i = 1;

    while(x(i) < b)
       % 3a) 
       % Euler
       y_euler(i+1) = y_euler(i) + h * f(x(i), y_euler(i));

       % Mittelpunkt
       x_h2 = x(i) + h/2;
       y_h2 = y_mittelpunkt(i) + h/2*f(x(i), y_mittelpunkt(i));
       y_mittelpunkt(i+1) = y_mittelpunkt(i) + h*f(x_h2, y_h2);

       % 3b)
       % Schrittweite anpassen
       if (abs(y_euler(i+1) - y_mittelpunkt(i+1)) < tol/20) 
           x(i+1) = x(i) + h;
           h = h*2;      
           i = i + 1;       
       else
           if (abs(y_euler(i+1) - y_mittelpunkt(i+1)) >= tol)
               h = h/2;
           else 
               x(i+1) = x(i) + h;
               i = i + 1;
           end
       end

       h_tab(i) = h;
    end

    % 3.c)
    figure(1)
    plot(x, 3*(1-exp(-10*x)).*exp(-2*x), 'r', x, y_mittelpunkt, '--b');
    legend('exakt', 'angen?hert');
    title('Vergleich');
    figure(2)
    plot(x, h_tab)
    title('Variable h in Abh?ngigkeit der Zeit');
end

