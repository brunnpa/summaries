function [y,ydiff,yint] = Brunner_Pascal_Gruppe4_S1_Aufg2(a,xmin,xmax)

    % Error handling, falls kein Zeilenvektor eingegeben wird
    dim = size(a);
    if dim(1,1) ~= 1
        error ('Falscher Input. Bitte geben Sie einen Zeilenvektor ein.')
    end

    % Definiert das Intervall
    x = xmin : 0.1 : xmax;

    %Die Anzahl Komponenten des Vektors a wird in n abgespeichert, da es
    % den Grad des Polynoms definiert.
    n = numel(a);


    % Initialisierung der lokalen Variablen.
    y = 0;
    ydiff = 0;
    yint = 0;

    % For-Loop für Berechnung des Polynoms
    for n = 1 : n 
        y = y + a(n)*x.^n;
    end

    % For-Loop für Berechnung der Ableitung des Polynoms
    for n = 1 : n
        ydiff = ydiff + a(n) * (n * x.^(n-1));
    end

    % For-Loop für Integral des Polynoms
    for n = 1 : n
       yint = yint + a(n) * (x.^(n+1)/(n+1)); 
    end
   
    
    % y, y' und Y plotten
    hold on;
    plot(x, y, 'r');
    plot(x, ydiff, 'g');
    plot(x, yint, 'b');
    legend('y', 'yDiff', 'Y');
    hold off;
    
    
end