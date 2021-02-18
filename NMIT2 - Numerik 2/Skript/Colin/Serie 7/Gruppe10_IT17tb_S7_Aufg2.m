% Löst das Anfangswertproblem mit dem Adams-Bashforth Methode 4ter Ordnung
% Die fehlenden Startwerte werden mit dem Runge Kutta Verfahren berechnet
%
% PARAMETER
% f = die Funktion
% a,b = Intervall
% n = Anzahl Berechnungsschritte
% y0 = Anfangswert für f(a)
%
% RETURN
% x = xi Werte
% yab4 = yi Werte
%
% SAMPLE
% [x,yab4] = Gruppe10_IT17tb_S7_Aufg2(@(x,y)x.^2 + 0.1 * y,-1.5,1.5,5,0)
function [x,yab4] = Gruppe10_IT17tb_S7_Aufg2(f,a,b,n,y0)
    % Adams-Bashforth Methode 4. Ordnung aus Aufgabe 1
    adam_bashforth_4te = @(f,x,y,h,i) y(i) + (h/24)*((55*f(x(i),y(i)) - (59*f(x(i-1),y(i-1))) + (37*f(x(i-2),y(i-2))) - (9*f(x(i-3), y(i-3)))));

    % Initialisieren
    h = (b-a)/n;
    x = zeros(n+1,1);
    yab4 = zeros(n+1,1);

    % Berechner der Anfangswerte y(1) bis y(3)
    berechnungsschritte = 3;
    neues_b_nach_3_schritten = a + berechnungsschritte*h;
    [x_runge,y_runge] = HELPER_S6_RUNGE_KUTTA(f,a,neues_b_nach_3_schritten,berechnungsschritte, y0);

    % Füllen der ersten 3 Werte in den Vektor für das Adam Verfahren
    for i=1:(berechnungsschritte+1)
        x(i) = x_runge(i);
        yab4(i) = y_runge(i);
    end
    
    % Berechnen der weiteren Schritte mit dem Adam Verfahren
    for i=5:n+1
        x(i) = x(i-1) + h;
        yab4(i) = adam_bashforth_4te(f,x,yab4, h, i-1) ;
    end
end

