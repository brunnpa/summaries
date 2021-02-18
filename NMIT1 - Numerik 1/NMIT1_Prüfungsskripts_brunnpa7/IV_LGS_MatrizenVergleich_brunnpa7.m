% Hilfsfunktion für die Berechnung der LR-Zerlegung

function [eqEps, eqReal] = IV_LGS_MatrizenVergleich_brunnpa7(A1,A2)
C = A1-A2;
eqEps = isequal(C<=eps,ones(size(A1)));
eqReal = A1 == A2;
end