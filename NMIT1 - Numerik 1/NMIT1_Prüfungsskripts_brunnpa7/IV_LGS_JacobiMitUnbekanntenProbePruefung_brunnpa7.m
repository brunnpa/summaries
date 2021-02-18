% JACOBI VERFAHREN gemäss Probeprüfung mit einer unbekannten a
%
% OUTPUT:
% x = x-Wert nach dem jeweiligen Schritt -> müsste man noch in einen
% for-loop packen
%
function [x] = IV_LGS_JacobiMitUnbekanntenProbePruefung_brunnpa7
clear 
format long

syms a
D = [30 0 0 ; 0 a 0 ; 0 0 50]
L = [0 0 0 ; 10 0 0; 5 20 0]
R = [0 10 5 ; 0 0 20; 0 0 0]
b = [5*a; a; 5*a]

DInv = inv(D)


LPlusR = L+R

MinusDInvMultLPlusR = -DInv * LPlusR

MinusDInvMultMinusB = -DInv * -b

startVektor = [a;0 ; a]


x = MinusDInvMultLPlusR * startVektor + MinusDInvMultMinusB


% Jetzt einfach nur mehr "startVektor = MinusDInvMultLPlusR * startVektor +
% MinusDInvMultMinusB" n Iterationen ausführen und man bekommt ein
% Ergebnis

end