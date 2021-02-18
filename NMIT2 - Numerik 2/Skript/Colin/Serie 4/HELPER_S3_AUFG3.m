% Berechnet die Näherung an das Integral mithilfe der Rhomberg
% Extrapolation
% 
% PARAMETER
% f = die Funktion
% a = startwert des Integrals
% b = endwert des Integrals
% m = Anzahl T am Eingang (ohne null. Das heisst, sollte die Tabelle 4
% Zeilen haben, geben Sie 4 ein.
%
% RETURN
% T = Näherung der Extrapolation
%
% SAMPLE
% Gruppe10_IT17tb_S3_Aufg3(@(x) 1/x, 2, 4, 4)
function [T] = HELPER_S3_AUFG3(f,a,b,m)

    if b < a
        error('b kann nicht kleiner sein als a')
    end
    
    % h Werte berechnen
    for i = 1:m
        h(i) = (b-a) / (2^(i-1));
    end
    % Resultatmatrix erstellen
    T = zeros(m);
    % Dieser ist in jeder Iteration gleich
    constantPart = (f(a)+f(b))/2 ;
    
    % Erste Spalte der Matrix berechnen
    for i=1:m 
        sum = 0;
        for j=1:((2^(i-1))-1)
            sum = sum +  f(a+j*h(i));    
        end
        T(i,1) = ( h(i) * (constantPart + sum) );  
    end
    
    % Alle weiteren auf Basis der ersten Spalte berechnen
    for j=2:m
        for k=1:(m-(j-1))
            T(k,j) = (2^j*T(k+1,j-1) - T(k,j-1))/(2^j-1); 
        end  
    end
    T = T(1,m);
end