function [yy, a, b, c, d] = kubische_splinefunktion(x,y,xx)
%Kubische Splinefunktion Summary of this function goes here
%   x: Stützstellen (aufsteigend sortiert)
%   y: Stützwerte
%   xx: Werte für welche y berechnet werden soll
%  kubische_splinefunktion([0,1,2,3],[2,1,2,2],[ 0.5 0.8 1.1 2.2])
if ~(size(x) == size(y))
    error("x und y müssen dieselben Dimensionen haben");
end
n = size(x,2)
a = y(1:(n-1));
h = x(2:n) - x(1:(n-1));
z = (3.*(y(3:n)-y(2:(n-1)))./h(2:(n-1))) - (3.*(y(2:(n-1))-y(1:(n-2)))./h(1:(n-2)));

diagonale = 2.*(h(1:(end-1))+h(2:end));
diagonale_above = h(2:(end-1));
diagonale_below = h(2:(end-1));
A = diag(diagonale) + diag(diagonale_above, 1) + diag(diagonale_below, -1);

c = zeros(1,size(x,2));
c(2:(end-1)) = A\z';
b = (y(2:end) - y(1:(end-1))./h) - ((h./3).*(c(2:end)+2.*c(1:(end-1))));
d = (1./(3.*h)).*(c(2:end)-c(1:(end-1)));

n = size(x,2) -1;
for j=1:n
    S = @(inp) a(j) + b(j)*(inp-x(j)) + c(j)*(inp-x(j)).^2 + d(j)*(inp-x(j)).^3;
    r = find(x(j)<=xx & xx<=x(j+1));        
   if not(isempty(r))
        yy(r) = S(xx(r));
   end
end

