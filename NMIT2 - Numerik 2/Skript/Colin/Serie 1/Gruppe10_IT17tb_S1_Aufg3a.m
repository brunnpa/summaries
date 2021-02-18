% Berechnet ein Array aus Vorwärts, Rückwärts und Zentraldifferenz
% Ableitungen
% 
% PARAMETER
% x = erstes Array
% y = zweites Array
%
% RETURN
% dx = Array von Ableitungen
% SAMPLE
% [dx] = Gruppe10_IT17tb_S1_Aufg3a([0:10],log(0:10))
function [dx] = Gruppe10_IT17tb_S1_Aufg3a(x,y)
    % Länge Array x
    len_arrX = length(x);
    % Länge Array y
    len_arrY = length(y);
    if len_arrX ~= len_arrY
        error("Arrays sind nicht gleich lang");
    end
    n = len_arrX;
    % Falls beide Arrays gleich gross sind -> erstelle ein neues Array für
    % dx welches die erste Ableitung enthalten wird
    dx = zeros(1,n);
    vorwDif = @(y, yNext, x, xNext) (yNext - y) / (xNext-x);
    ruckwDif = @(yPrev, y, xPrev, x) (y - yPrev) / (x - xPrev);
    zentrDif = @(yPrev, yNext, xPrev, xNext) (yNext - yPrev) / (xNext - xPrev);
    for i=1:n
        if i==1
            % Vorwärtsdifferenz
            dx(i) = vorwDif(y(i), y(i+1), x(i), x(i+1));
        elseif i==n
            % Rückwärtsdifferenz
            dx(i) = ruckwDif(y(i-1), y(i), x(i-1), x(i));
        else
            % Zentraldifferenz
            dx(i) = zentrDif(y(i-1), y(i+1), x(i-1), x(i+1));
        end
    end
end

