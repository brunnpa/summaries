% Erstellt ein Richtungsfeld für eine Funktion
%
% PARAMETER
% f = the function
% a = startwert
% b = endwert
% n = anzahl iterationen
% y0 = y wert wenn startwert a in funktion
%
% RETURN
% x = sämtliche Schritte
% y_euler = resultate für das Eulerverfahren
% y_mittelpunkt = resultate für das Mittelpunktverfahren
% y_modeuler = resultate für das modifizierte Eulerverfahren
%
% SAMPLE
% [x, y_euler, y_mittelpunkt, y_modeuler] = Gruppe10_IT17tb_S5_Aufg3(@(x,y) x.^2 ./ y ,0,2.1,3,2)
function [x, y_euler, y_mittelpunkt, y_modeuler] = Gruppe10_IT17tb_S5_Aufg3(f,a,b,n,y0)
    %% Vektoren erstellen gemäss Aufgabenstellung
    y_euler = zeros(1,n+1);
    y_mittelpunkt = zeros(1,n+1);
    y_modeuler = zeros(1,n+1);
    y_modeuler_hoch_euler = zeros(1,n);
    x = zeros(1,n+1);

    %% Konstanten und Anfangswerte vorbereiten
    h = (b-a)/n;
    x(1)= a;
    y_euler(1) = y0;
    y_mittelpunkt(1) = y0;
    y_modeuler(1) = y0;
    %% Euler berechnen
    for i=1:n
        x(i+1) = x(i) + h;
        % Euler-Verfahren
        y_euler(i+1) = y_euler(i) + h * f( x(i),y_euler(i) );

        % Mittelpunkt Verfahren
        % Nur die halbe Schrittweite wird verwendet, die neue Steigung dann
        % jedoch für die ganze Schrittweite
        x_h2 = x(i) + h/2;
        y_h2 = y_mittelpunkt(i) + h/2 * f( x(i),y_mittelpunkt(i) );
        y_mittelpunkt(i+1) =  y_mittelpunkt(i) + h * f( x_h2, y_h2 );

        % modifiziertes Euler-Verfahren
        k1 = f( x(i), y_modeuler(i) );
        y_modeuler_hoch_euler(i) = y_modeuler(i) + h * k1;
        k2 = f(x(i+1),y_modeuler_hoch_euler(i));
        y_modeuler(i+1) = y_modeuler(i) + h * 1/2 *(k1 + k2);
    end

    % Grafik des Richtungsfeldes
    figure('Name','Alle Verfahren');
    hold on
    Gruppe10_IT17tb_S5_Aufg1(f,a, b, y0, 3.26 , 0.1, 0.1);
    y = @(x) sqrt(2*x.^3/3 +4);
    plot(x, y_euler);
    plot(x, y_mittelpunkt);
    plot(x, y_modeuler);
    plot(x, y(x));
    legend('Richtungsfeld','Eulerverfahren', 'Mittelpunktverfahren','Modifizierter Euler', 'Exakt');
end