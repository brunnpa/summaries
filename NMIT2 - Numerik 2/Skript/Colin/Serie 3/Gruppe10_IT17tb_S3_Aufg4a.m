% Berechnet das Integral auf Basis einer Wertetabelle
% 
% PARAMETER
% x = Vektor
% y = Vektor
%
% RETURN
% Tf_neq = das berechnete Integral
%
% SAMPLE
% [Tf_neq] = Gruppe10_IT17tb_S3_Aufg4a([1 2 4 8],[1 2 4 8])
function [Tf_neq] = Gruppe10_IT17tb_S3_Aufg4a(x,y)
    summe = 0;
    sizeOfX = size(x,2);

    for i = 1:(sizeOfX-1)
        % Teil 1 benutzt y, da f(x) = y
        zaehlerTeil1 = y(i) + y(i+1);
        % Teil 2 benutzt x
        zaehlerTeil2 =  x(i+1)-x(i);
        % Gemäss Formel: Teil1*Teil2 / 2
        summe = summe + (zaehlerTeil1*zaehlerTeil2)/2;
    end
    Tf_neq=summe;
end