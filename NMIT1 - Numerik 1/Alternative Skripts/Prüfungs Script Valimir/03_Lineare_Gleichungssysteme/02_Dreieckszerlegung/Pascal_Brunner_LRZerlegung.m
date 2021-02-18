% LR-Zerlegung
%
% INPUT: 
% A = n x n Matrix
%
% OUTPUT
% L = ist eine normierte untere Dreiecksmatrix
% R = ist eine obere Dreiecksmatrix
% y = wurde durch vorwärtseinsetzen von Ly = b ermittelt
% x = wurde durch rückwärtseinsetzen von Rx = y ermittelt
%
% BEISPIELAUFRUF:
% Pascal_Brunner_LRZerlegung([9 12 6; 12 25 23; 6 23 78],[1;40;75])

function [L, R, y, x] = Pascal_Brunner_LRZerlegung(A, b)

% Grösse des Arrays bzw. Dimension der Matrix bestimmen
n = size(A);
n = n(1);

% L initial erstellen in dem man die EInhetismatrix erstellt
L = eye(n);

% R initial erstellen in dem man eine n-Matrix mit 0 befüllt
R = zeros(n);

for i = 1 : 1 : n-1
   % Überprüfung ob LR-Zerlegung möglich ist 
   if(A(i,i)==0) 
      disp('LR-Zerlegung nicht möglich, weil Zeilenvertauschung notwendig ist'); 
   end
   for j = i+1 : 1 : n 
       % r wird für die LR-Zerlegung bzw. den Eliminationsschritt gebraucht
       r = A(j,i)/A(i,i);
       
       % A(j, :) gibt die ganze Zeile(j) aus
       A(j, :) = A(j, :) - r*A(i,:);
       % L(j, i) wird gleich r gesetzt, da man das Resultat von r jeweils
       % direkt auslesen kann und an die entsprechende Stelle setzen kann.
       L(j, i) = r;
   end
end

% Finale Zuweisung
R = A;
y = L\b;
x = R\y;

% Ausgabe der Resultate
disp('obere Dreiecksmatrix R= ');
disp(R);
disp('normierte untere Dreiecksmatrix L = ');
disp(L);
disp('durch vorwärtseinsetzen Ly = b => y = ');
disp(y);
disp('durch rückwärtseinsetzen Rx = y => x = ');
disp(x);


end