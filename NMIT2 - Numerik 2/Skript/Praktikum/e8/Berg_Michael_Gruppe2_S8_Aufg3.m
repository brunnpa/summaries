function [] = Berg_Michael_Gruppe2_S8_Aufg3()
    a = 0;
    b = 10;
    f = @(t, y) -12*y + 30 * exp(-2*t);
    y0 = 0;

    % 3a)
    h = 0.01;
    n = (b-a)/h;
    [x_k, y_k] = euler(f, a, b, n, y0);
    [x_m, y_m] = mittelpunktverfahren(f, a, b, n, y0);
    figure
    plot(x_k, y_k, x_m, y_m);
    title('3a)');
    legend('Euler', 'Mittelpunktverfahren');
    xlabel('t');
    ylabel('y');


    % 3b)
    TOL = 1e-2;
    h_adpt = h;
    t_adpt = a;

    y_adpt = 0;
    y_str = 0;



    k = 1;
    while (t_adpt(k) < b)
        % Mittelpkt
        k1 = f(t_adpt(k), y_adpt(k));
        k2 = f(t_adpt(k)+ h_adpt(k)/2, y_adpt(k)+h_adpt(k)/2 * k1);
        y_adpt(k+1) = y_adpt(k) + h_adpt(k) * k2;
        t_adpt(k+1) = t_adpt(k) + h_adpt(k);

        % Euler
        y_str(k+1) = y_adpt(k) + h_adpt(k) * k1;

        % h verdoppeln
        if (abs(y_adpt(k+1) - y_str(k+1)) < TOL/20)
            h_adpt(k+1) = 2 * h_adpt(k);
            k = k+1;
            continue;     
        end

        % h halbieren
        if (abs(y_adpt(k+1) - y_str(k+1)) >= TOL)
            h_adpt(k) = (1/2) * h_adpt(k);
            continue;
        end
        
        h_adpt(k+1) = h_adpt(k);
        k = k+1;
    end

    % 3c)
    y_exact = @(t) 3 .*(1-exp(-10.*t)) .* exp(-2.*t);

    figure
    subplot(2,1,1);
    t = a:0.01:b;
    plot(t_adpt, y_adpt, 'r', t, y_exact(t), '--b');
    legend('Numerisch berechnete Funktion', 'Exakte Funktion');
    xlabel('t');
    ylabel('y');

    title('Teilaufgabe c');

    subplot(2,1,2);
    plot(t_adpt, h_adpt);
    legend('Adaptive Schrittweite');
    xlabel('t');
    ylabel('h');

    % 3d)
    % Wird die Toleranz zu gross gew?hlt ist, ist die angen?herte Kurve weniger
    % genau.
    % 
    % Je kleiner die Toleranz, umso genauer das Ergebnis, jedoch dauert die Berechnung
    % l?nger. Die Zunahme der Genauigkeit wird durch den Rundungsfehler
    % aufgrund von eps (Maschinengenauigkeit) beschr?nkt.
end