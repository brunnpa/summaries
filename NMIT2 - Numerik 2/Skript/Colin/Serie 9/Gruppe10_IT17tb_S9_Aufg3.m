% Macht eine Polynominterpolation mit dem Aitken-Neville Schema 
%
% PARAMETER
% x = der Vektor mit den Stützstellen
% y = der analoge Vektor mit den bekannten Stützstellen
% xj = die Stützstelle für welche das Schema ausgewertet werden soll
%
% RETURN
% yj = der interpolierte Wert
%
% SAMPLE
% [yj] = Gruppe10_IT17tb_S9_Aufg3([0,2500,5000,10000],[1013,747,540,226],1250)
% [yj] = Gruppe10_IT17tb_S9_Aufg3([0,2500,5000,10000],[1013,747,540,226],3750)
function [yj] = Gruppe10_IT17tb_S9_Aufg3(x,y,xj)
    sizeX = size(x,2);
    sizeY = size(y,2);
    
    % Error handling
    if(sizeX ~= sizeY)
        error('Vektordimension sind nicht gleich');
    end

    n = sizeX;
    P= zeros(n); 
    
    % Erste Spalte mit y füllen. P(i,j) wobei i = zeile und j = spalte
    for i = 1:n
        P(i,1) = y(i);
    end

    for i=1:n-1 
        for j = 1:n-1
            % Falls Spaltennummer grösser als Zeilennummer ist es 0 -> Dreieck Form 
            if(j>i)
                P(i+1,j+1) = 0;
            else 
                % -1 muss nicht gemacht werden für i sowie j da start bei 1
                zaehler = (x(i+1)-xj) * P(i,j) + (xj - x(i-j+1)) * P(i+1, j);
                nenner = (x(i+1)-x(i-j+1));
                P(i+1,j+1) = (zaehler / nenner);
            end
        end
    end
    yj = P(end);
end

