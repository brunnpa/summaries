%{
DIAGONALDOMINANZ - prüft, ob eine Matrix diagonaldominant ist

INPUT:
A: die zu überprüfende Matrix

OUTPUT:
dominant: 1, falls Matrix dominant ist
Zeilensummenkriterium: 1, falls Zeilensummenkriterium erfüllt
Spaltensummenkriterium: 1, falls Zeilensummenkriterium erfüllt

TESTDATEN:

Zeilen- und Spalten ok:
A = [12 4 3; 5 16 4; 2 3 18]

Nur Zeilen ok:
B = [12 1 10; 6 13 5; 8 4 14]

Nichts ok:
C = [1 4 5; 7 2 6; 8 9 3]

FUNKTIONIERENDER AUFRUF: 
[dominant, Zeilensummenkriterium, Spaltensummenkriterium] = IV_LGS_DiagonalDominanz_brunnpa7([12 4 3; 5 16 4; 2 3 18])

%}

function [dominant, Zeilensummenkriterium, Spaltensummenkriterium] = IV_LGS_DiagonalDominanz_brunnpa7
A = [10 4 2; 5 20 8; 15 5 30];
% Werte der Matrix betragsmässig nehmen
abs_A = abs(A);

% Spalten- und Zeilensummen summerien, Spaltensumme transponieren, 
% damit Vergleich später mit dia funktioniert
Spaltensumme = sum(abs_A).';
Zeilensumme = sum(abs_A,2);

% Diagonale initialisieren
dia = diag(abs_A);

% Kriterien überprüfen und zuweisen
% dia wird mal 2 gerechnet, da auch in der jeweiligen Summe vorhanden
Zeilensummenkriterium = all(Zeilensumme <= 2 * dia);
Spaltensummenkriterium = all(Spaltensumme <= 2 * dia);
dominant = Zeilensummenkriterium || Spaltensummenkriterium;

end