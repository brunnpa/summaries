% Ableitung durch Extrapulation mit dem h^2-Algorithmus
% 
% PARAMETER
% f = Funktion zum Ableiten
% x0 = Die Stelle wo abgeleitet werden soll
% h0 = Startwert für die Schrittweite
% n = Genauigkeit
%
% RETURN
% D = Näherung Ableitung mit Extrapulation
%
% SAMPLE
% HELPER_S2_AUFG2(@(x) log(x.^2), 2, 0.1, 4)
function [D] = HELPER_S2_AUFG2(f, x0, h0, n)

format long;

for i = 1:n
    h = h0/2^(i-1);
    values_before(i) = (f(x0 + h) - f(x0)) / h; 
end


for i = 1:(n-1)
   for j = 1:(n-i)
      values_after(j) = (4^i * values_before(j+1) - values_before(j)) / (4^i - 1);
   end
   values_before = values_after;
end

D = values_after(1);