function    [ y, p ]   =   aiktenNeville( x, y, xj )
%Test:      [ y, p ]        =   aiktenNeville( [0, 2500, 5000, 10000], [1013, 747, 540, 226], 1250 )
% Params:
% x: St?tzstellen
% y: Funktionswerte der St?tzstellen
% xj: Stelle an der Interpolation berechnet werden soll
%Ouputs: Interpolierter Funktionswert an Stelle xj
%y = Pn(xj) = pnn(xj)
%p = Aitken neville schema
n = length(x);

if(n ~= length(y))
    err('Vektor y und x müssen gleich lang sein');
end
p = zeros(n);

p(:,1) = y;

i = 2;
j = 2;

p(i,j) = ((x(i)-xj).*p(i-1,j-1)+(xj-x(i-j+1)).*p(i,j-1)) / (x(i)-x(i-j+1));
    

for i = 2:n
    for j = 2:i
        p(i,j) = ((x(i)-xj)*p(i-1,j-1)+(xj-x(i-j+1))*p(i,j-1)) / (x(i)-x(i-j+1));
    end
end
    
y = p(n,n);
end

