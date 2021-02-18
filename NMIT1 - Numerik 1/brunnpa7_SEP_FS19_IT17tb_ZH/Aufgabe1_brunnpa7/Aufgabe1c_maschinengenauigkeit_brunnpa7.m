% Berechnung des Maschinenepsilons mit Basis B und n = Anzahl Stellen.
%
% Beispiel:
% [eps] = Aufgabe1c_maschinengenauigkeit_brunnpa7
%
function [eps] = Aufgabe1c_maschinengenauigkeit_brunnpa7
    B = 2;
    n = 7;
    eps = (B/2)*B.^(-n);
end

% Bei Vergleich von Maschinengenauigkeiten gilt
% umso kleiner desto besser!