function Berg_Michael_Gruppe2_S4_Aufg2()
    % Aufgabe 2.a)
    % n zu klein gewählt -> Ungenauigkeit für Fehler verantwortlich

    n = 3;
    
    % Widerstand
    R = 50;
    
    % Spannung
    V = @(t) 3500*sin(140*pi*t).*exp(-63*pi*t); 
    
    % Energie
    E = @(t) V(t).^2/R; 

    % x-Achse
    x = linspace(0, 0.05, 100); 
    
    % Ergebnis
    E_t = zeros(1, length(x)); 
    index = 1;

    % Integral berechnen
    for t = x
       E_t(index) = Berg_Michael_Gruppe2_S3_Aufg3(E, 0, t, n);
       index = index + 1;
    end

    yyaxis left
    plot(x, V(x));
    ylabel('Spannungspuls V(t) [V]');
    xlabel('Zeit [s]');

    yyaxis right
    plot(x, E_t);
    ylabel('Energie E(t) [J]');

    % Aufgabe 2.b)
    % Die Nullstelle befindet sich zwischen 

    clc
    clear

    n = 3;
    
    % Widerstand
    R = 50;
    
    % Spannung
    V = @(t) 3500*sin(140*pi*t).*exp(-63*pi*t);
    
    % Energie
    E = @(t) V(t).^2/R;
    
    % Nullstellenproblem
    f = @(t) E(t)-250;
    
    % Schrittweite zu Beginn für h^2-Algorithmus
    h = 0.01;
    
    % Fehlerschranke
    epsilon = 1e-5;
    
    % Startwert
    xn = 5e-3;

    while ((f(xn - epsilon) * f(xn + epsilon)) > 0) 
        % Ableitung
        fdiff = Berg_Michael_Gruppe2_S2_Aufg2(f, xn, h, n);
        % Newton Verfahren
        xn1 = xn - (f(xn)./fdiff);
        xn = xn1; 
    end

    % Ausgabe Zeitwert
    fprintf('t = %i\n', xn);

    tx = linspace(4e-3, 16e-3);
    figure
    hold on
    plot(tx, E(tx));
    plot(xn, E(xn), 'o');


end