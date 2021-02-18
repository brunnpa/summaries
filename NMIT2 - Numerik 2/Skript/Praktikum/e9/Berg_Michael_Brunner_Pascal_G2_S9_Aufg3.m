% x  = Vektor mit geg. Stützstellen
% y  = Vektor mit geg. Stützstellen
% xj = Stützstelle, für welche das Schema ausgewertet werden soll
% yj = interpolierter Wert von y-Wert bei Punkt xj

% 1.NAN = Berg_Michael_Brunner_Pascal_G2_S9_Aufg3([0,2500,5000,10000],[1013,747,540,226],1250)
% 2.NAN = Berg_Michael_Brunner_Pascal_G2_S9_Aufg3([0,2500,5000,10000],[1013,747,540,226],3750)

function [yj] = Berg_Michael_Brunner_Pascal_G2_S9_Aufg3(x,y,xj)

if(size(x,2) ~= size(y,2))
    perror("Vektorgrössen stimmen nicht überein.");
end

n = size(x,2);

P= zeros(n); 
for i = 1:n
    P(i,1) = y(i);
end

for i=1:n-1 
    for j = 1:n-1 
       if(j>i)
        P(i+1,j+1) = 0;
       else 
        P(i+1,j+1) = ((x(i+1)-xj) * P(i,j) + (xj - x(i-j+1)) * P(i+1, j))/(x(i+1)-x(i-j+1));
       end
    end
end

yj = P(end);

end