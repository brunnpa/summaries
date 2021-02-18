% Inputwerte
xi = [0, 2500, 5000, 10000];
yi = [1013, 747, 540, 226];
x = 3750;

p = aitkenNeville(xi,yi,x);
disp(p)
disp(p(end,end));

% Implementation des Aitken-Neville Schema 
% Input:
% x = Vektor mit den Stützstellen
% y = Vektor mit den Stützwerten
% xGes = Stützstelle, für welche das Schema ausgewertet werden soll
% Output:
% p = P-Matrix, interpolierter Wert an p(end,end)
function [p] = aitkenNeville(x, y, xGes)
    if (length(x) ~= length(y)) 
        error('x und y müssen die gleiche Dimension besitzen');
    end
    
    n = length(x);
    p = zeros(n);
    
    p(:,1) = y;
    for i = 1:n
        if (i > 1)
           for j = 1:i
               if (j > 1)
                   p(i,j) = ((x(i) - xGes) * p(i-1, j-1) + (xGes - x(i-(j-1))) * p(i, j-1)) / (x(i) - x(i-(j-1)));
               end
           end 
        end
    end
end