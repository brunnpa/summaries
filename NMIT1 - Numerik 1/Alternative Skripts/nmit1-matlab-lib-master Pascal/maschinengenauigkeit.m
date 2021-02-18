% Berechnung des Maschinenepsilons mit Basis B und n = Anzahl Stellen.
%
% Beispiel:
% [eps] = maschinengenauigkeit(10,14)
%
function [eps] = maschinengenauigkeit(B,n)
    eps = (B/2)*B.^(-n);
end

% Bei Vergleich von Maschinengenauigkeiten gilt
% umso kleiner desto besser!